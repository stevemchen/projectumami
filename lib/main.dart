import 'package:flutter/material.dart';
import 'package:umai/app.dart';
import 'ui/screens/login.dart';

void main() => runApp(
      new RecipesApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
