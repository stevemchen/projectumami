import 'package:flutter/material.dart';
import 'package:umami/models/ingredient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class IngredientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IngredientMainPage(),
      theme: ThemeData(fontFamily: 'Nunito'),
    );
  }
}

class IngredientMainPage extends StatefulWidget {
  @override
  _IngredientMainPageState createState() => _IngredientMainPageState();
}

class _IngredientMainPageState extends State<IngredientMainPage> {
  List<Ingredient> listIngre = new List<Ingredient>();
  var length;
  Future<Ingredient> _fetchIngredient() async {
    final response = await http.get(
        'https://api.spoonacular.com/food/ingredients/substitutes?ingredientName=butter&apiKey=45eaba7f12a54861a03e0177818c82c0');
    if (response.statusCode == 200) {
      var jsonRes = json.decode(response.body);

      if (jsonRes.length > 0) {
        for (int i = 0; i < jsonRes.length; i++) {
          if (jsonRes[i] != null) {
            Map<String, dynamic> map = jsonRes[i];
            listIngre.add(Ingredient.fromJson(map));
          }
        }
      }
      setState(() {
        length = jsonRes.length;
        print('object length: ${jsonRes.length}');
      });

      return Ingredient.fromJson(jsonRes);
    } else {
      throw Exception('failed to load ingredient');
    }
  }

  Future<Ingredient> futureIngredient;
  @override
  void initState() {
    futureIngredient = _fetchIngredient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Ingredient')),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text('Ingredient length: '),
              Container(
                height: MediaQuery.of(context).size.height - 100,
                width: double.infinity,
                child: FutureBuilder(
                  future: futureIngredient,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                              )
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      'Ingredient: ${snapshot.data.ingredient}'),
                                  Text('Message: ${snapshot.data.message}',
                                      style: TextStyle(color: Colors.grey)),
                                  Container(
                                    height: 100,
                                    child: ListView.builder(
                                        itemCount: length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  '-Sub${index}: ${snapshot.data.substitutes[index]}',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(.7))),
                                            ],
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: 1,
                      );
                    } else if (snapshot.hasError) {
                      return new Text(
                          'An error ocurr: ${snapshot.error.toString()}');
                    }

                    return Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        child: new CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
