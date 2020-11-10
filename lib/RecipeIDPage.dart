import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:umami/ProductionInfo.dart';
import 'package:umami/models/recipe_model.dart';
import 'package:umami/spoonacular.dart';
import 'package:umami/ui/screens/recipe_screen.dart';
import 'package:umami/models/IngredientID.dart';
import 'package:umami/models/NutrientID.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class RecipeIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Nunito'), home: RecipeIdPageMain());
  }
}

class RecipeIdPageMain extends StatefulWidget {
  final image;
  final int id;
  final String title;
  final isFindButton = true;
  const RecipeIdPageMain({Key key, this.image, this.id, this.title})
      : super(key: key);

  @override
  _RecipeIdPageMainState createState() => _RecipeIdPageMainState();
}

class _RecipeIdPageMainState extends State<RecipeIdPageMain> {
  String recipeURL;
  String title;
  String baseUrl = "https://api.spoonacular.com/recipes/";
  String keyID =
      "/ingredientWidget.json?apiKey=46b60620dcee4f78aba8730bd9f9fcae";
  String url;
  String baseUrl2 = "https://api.spoonacular.com/recipes/";
  String keyID2 =
      "/nutritionWidget.json?apiKey=46b60620dcee4f78aba8730bd9f9fcae";
  String url2;

  Future<IngredientID> futureIngre;
  //  Future<NutrientID> futureNutri;

  @override
  void initState() {
    getOriginalRecipeURL();
    super.initState();
  }

  Future<IngredientID> _fecthSearch() async {
    http.Response response =
        await http.get(baseUrl + widget.id.toString() + keyID);
    print(baseUrl + widget.id.toString() + keyID);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return IngredientID.fromJson(json);
    } else {
      throw Exception('failed to load search recipe');
    }
  }

  Future<NutrientID> _fecthSearchNutrient() async {
    http.Response response =
        await http.get(baseUrl2 + widget.id.toString() + keyID2);
    print('search nutrient: ${baseUrl2 + widget.id.toString() + keyID2}');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return NutrientID.fromJson(json);
    } else {
      throw Exception('failed to load search nutrients recipe');
    }
  }

  Future<String> getOriginalRecipeURL() async {
    this.url = await retrieveRecipe(widget.id.toString());
    return this.url;
  }

  Future saveRecipe() async {
    recipeURL = await getOriginalRecipeURL();
    print('Storing ' + recipeURL.toString());
    try {
      await FireStoreService()
          .addRecipe(SavedRecipe(widget.id, recipeURL.toString()));
    } catch (e) {
      return e.message;
    }
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("saved_recipes").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.get('id'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            tooltip: 'Product Information',
            elevation: 10,
            child: Center(child: Icon(Icons.pie_chart, color: Colors.white)),
            onPressed: () {
              // launch should be async, and we're supposed to call it in an
              // async function. This is bad practice so far, but it works well
              // enough.
              launch(url);
              // Navigator.of(context).push(_createRoute());
            }),
        appBar: AppBar(title: Text('Recipe Details')),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(children: <Widget>[
                Hero(
                  tag: widget.image,
                  child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover)),
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.centerLeft,
                                  colors: [
                            Colors.black12,
                            Colors.black26,
                            Colors.black45,
                            Colors.black54,
                            Colors.black87,
                          ])))),
                ),
                Text("ID: " + widget.id.toString(),
                    style: TextStyle(color: Colors.white)),
                Positioned(
                    top: 100,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(widget.title.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.3)),
                        )))
              ]),
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height + 210,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Ingredient',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.7))),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 100,
                        width: double.infinity,
                        child: FutureBuilder(
                            future: _fecthSearch(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return new Text(
                                    'error: ${snapshot.error.toString()}');
                              } else if (snapshot.hasData) {
                                IngredientID ingre = snapshot.data;
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: ingre.ingredients.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 175,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade100),
                                        child: ListTile(
                                          title: Text(snapshot
                                              .data.ingredients[index].name),
                                          subtitle: Text(
                                              '${ingre.ingredients[index].amount.metric.value.toString() + " " + ingre.ingredients[index].amount.metric.unit}\n${ingre.ingredients[index].amount.us.value.toString() + " " + ingre.ingredients[index].amount.us.unit}'),
                                        ),
                                      );
                                    });
                              }

                              return Center(
                                  child: new CircularProgressIndicator(
                                strokeWidth: 1,
                              ));
                            })),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Nutrient information',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    _getNutrientFactWiget(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Good nutrients',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    _buildGoodNutrient(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Bad nutrients',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    _buildBaddNutrient(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  //rout to move to other screen
  // Obsolete. Not used as launch(url) from url_launcher is used
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RecipeScreen(
        mealType: "1",
        id: widget.id,
        recipe: Recipe.fromMap({'spoonacularSourceUrl': url})),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _getNutrientFactWiget() {
    return FutureBuilder(
        future: _fecthSearchNutrient(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 50,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildNutrition(
                      color: Colors.red.shade200,
                      icon: Icons.pie_chart,
                      text: 'calories\n${snapshot.data.calories.toString()}'),
                  _buildNutrition(
                      color: Colors.deepOrange.shade200,
                      icon: Icons.spa,
                      text: 'carbs\n${snapshot.data.carbs.toString()}'),
                  _buildNutrition(
                      color: Colors.green.shade200,
                      icon: Icons.trip_origin,
                      text: 'fat\n${snapshot.data.fat.toString()}'),
                  _buildNutrition(
                      color: Colors.pink.shade200,
                      icon: Icons.tonality,
                      text: 'protein\n${snapshot.data.protein.toString()}'),
                ],
              ),
            );
          }
          return Center(
              child: Container(
            height: 20,
            width: 20,
            child: new CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ));
        });
  }

  Widget _buildNutrition({String text, IconData icon, Color color}) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(right: 10),
        width: 125,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Center(child: Icon(icon, color: Colors.white))),
            SizedBox(
              width: 10,
            ),
            Text(text,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54)),
          ],
        ));
  }

  Widget _buildGoodNutrient() {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTitle(title: 'Mineral', color: Colors.blue.shade200),
              _buildTitle(title: 'Amount', color: Colors.blue.shade200),
              _buildTitle(title: 'DailyNeeds', color: Colors.blue.shade200),
            ],
          ),
        ),
        Container(
          height: 300,
          width: double.infinity,
          child: FutureBuilder(
            future: _fecthSearchNutrient(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              NutrientID nutrient = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: nutrient.good.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        '${nutrient.good[index].title.toString()}'),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        '${nutrient.good[index].amount.toString()}'),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        '${nutrient.good[index].percentOfDailyNeeds.toString()}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.blue.shade400),
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return new Text('An error occur: ${snapshot.error}');
              }
              return Center(
                  child: new CircularProgressIndicator(
                strokeWidth: 1,
              ));
            },
          ),
        )
      ],
    );
  }

  Widget _buildBaddNutrient() {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTitle(title: 'Mineral', color: Colors.red.shade100),
              _buildTitle(title: 'Amount', color: Colors.red.shade100),
              _buildTitle(title: 'DailyNeeds', color: Colors.red.shade100),
            ],
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          child: FutureBuilder(
            future: _fecthSearchNutrient(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              NutrientID nutrient = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: nutrient.bad.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        '${nutrient.bad[index].title.toString()}'),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        '${nutrient.bad[index].amount.toString()}'),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        '${nutrient.bad[index].percentOfDailyNeeds.toString()}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.red.shade400,
                          ),
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return new Text('An error occur: ${snapshot.error}');
              }
              return Center(
                  child: new CircularProgressIndicator(
                strokeWidth: 1,
              ));
            },
          ),
        )
      ],
    );
  }

  //build title for list good nutrient
  Widget _buildTitle({String title, Color color}) {
    return Container(
        width: MediaQuery.of(context).size.width / 3 - 20,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
        child: Center(
            child: Text(title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))));
  }
}

class SavedRecipe {
  final int id;
  final String sourceurl;
  SavedRecipe(this.id, this.sourceurl);
  Map<String, dynamic> toJson() => {'id': id, 'url': sourceurl.toString()};
}

class FireStoreService {
  final CollectionReference _recipesCollectionReference =
  FirebaseFirestore.instance.collection("saved_recipes");
  Future addRecipe(SavedRecipe recipe) async {
    if (recipe.sourceurl == null) {
      print('url was null');
      exit(0);
    }
    try {
      await _recipesCollectionReference.doc().set(recipe.toJson());
    } catch (e) {
      return e.message;
    }
  }
}