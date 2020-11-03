import 'package:flutter/material.dart';
import 'package:umami/ui/screens/login.dart';
import 'package:umami/sign_in.dart';

import 'package:flutter/material.dart';
import 'RecipeListView.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Search"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: RecipeSearch());
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
      ),
    );
  }
}

class RecipeSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return MaterialApp(
        title: 'Recipe Results',
        home:
            Scaffold(appBar: AppBar(), body: Center(child: RecipeListView())));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Container();
    // TODO: implement buildSuggestions
    // build suggestions later by preloading ingredient list?
    throw UnimplementedError();
  }
}
