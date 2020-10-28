import 'dart:async';
import 'package:flutter/material.dart';
import 'package:umami/models/recipe_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:umami/spoonacular.dart';

class RecipeScreen extends StatefulWidget {
  //This stateful widget page takes in String mealType and Recipe recipe
  final String mealType;
  final int id;
  final Recipe recipe;

  RecipeScreen({this.mealType, this.id, this.recipe});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  @override
  Widget build(BuildContext context) {
    print("widget url: " + this.widget.recipe.spoonacularSourceUrl);
    return Scaffold(
      //AppBar is widget.mealType
      appBar: AppBar(
        title: Text('Web View'),
      ),
      /**
       * Body is a Webview. Ensure you have imported webview flutter.
       * 
       * initialUrl- spoonacularSourceUrl of our parsed in recipe
       * javascriptMode - set to unrestricted so as JS can load in the webview
       */
      body: WebView(
        initialUrl: this.widget.recipe.spoonacularSourceUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (value) { setState(() {
          print("load finished");
        });})
    );
  }
}
