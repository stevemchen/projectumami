import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:umami/models/RecipeRD.dart';
import 'package:umami/models/Recipe.dart';

class RandomRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RandomRecipePage(), theme: ThemeData(fontFamily: 'Nunito'));
  }
}

Future<Recipes> _fecthRandomRecipe2() async {
  final respone = await http.get(
      "https://api.spoonacular.com/recipes/random?number=8&tags=lunch&apiKey=45eaba7f12a54861a03e0177818c82c0");
  if (respone.statusCode == 200) {
    final jsonRes = jsonDecode(respone.body);
    // List<Recipes> recipeS = [];

    var returnvalue = Recipes.fromJson(jsonRes);
    return returnvalue;
  } else {
    throw Exception('failed to load Recipe2');
  }
}

Future<RDRecipe> _fetchRandomRecipe() async {
  var link =
      "https://api.spoonacular.com/recipes/random?number=10&tags=lunch&apiKey=45eaba7f12a54861a03e0177818c82c0";
  final respone = await http.get(link);

  if (respone.statusCode == 200) {
    final jsonRespone = jsonDecode(respone.body);

    return RDRecipe.fromJson(jsonRespone);
  } else {
    print('failed to load recipe');
    throw Exception('failed to load Recipe!!');
  }
}

class RandomRecipePage extends StatefulWidget {
  @override
  _RandomRecipePageState createState() => _RandomRecipePageState();
}

class _RandomRecipePageState extends State<RandomRecipePage> {
  Future<RDRecipe> futureRecipe;
  Future<Recipes> futureRecipe2;
  @override
  void initState() {
    futureRecipe = _fetchRandomRecipe();
    futureRecipe2 = _fecthRandomRecipe2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Food Random Recipe')),
        backgroundColor: Colors.white,
        body: Center(
          child: FutureBuilder(
            future: futureRecipe2,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(snapshot.data.recipes[index].sourceUrl),
                            subtitle: Text(
                                'Source name: ${snapshot.data.recipes[index].sourceName}\npricePerServing: ${snapshot.data.recipes[index].pricePerServing.toString()}'),
                          ),
                          Divider()
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
