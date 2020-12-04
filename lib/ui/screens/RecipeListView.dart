import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Recipe {
  final int id;
  final String title;
  final String ingredients;

  Recipe({this.id, this.title, this.ingredients});

  factory Recipe.fromMap(Map<String, dynamic> map) {
    String ingredients = 'apples,flour,sugar';
    return Recipe(
      id: map['id'],
      title: map['position'],
      ingredients: ingredients,
    );
  }
}

class RecipeListView extends StatelessWidget {
  Future<List<Recipe>> _fetchRecipes() async {
    String apiKey = "46b60620dcee4f78aba8730bd9f9fcae";
    // GET HTTP Request URL
    String url =
        "https://api.spoonacular.com/recipes/findByIngredients?apiKey=";
    url += apiKey;
    final response = await http.get(url);
    //Map<String, dynamic> data = json.decode(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((recipe) => new Recipe.fromMap(recipe)).toList();
    } else {
      throw Exception('Failed to load recipes from API');
    }
  }

  ListView _recipeListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].title, data[index].id);
        });
  }

  ListTile _tile(String title, String subtitle) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _fetchRecipes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Recipe> data = snapshot.data;
          return _recipeListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
