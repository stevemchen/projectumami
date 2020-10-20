import 'package:flutter/material.dart';
import 'package:umami/ui/screens/login.dart';
import 'package:umami/ui/screens/first_screen.dart';
import 'package:umami/ui/screens/Results.dart';
import 'package:umami/ui/screens/theme.dart';

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: buildTheme(), // New code
      initialRoute: '/login',
      routes: {
        '/': (context) => LoginPage(),
        '/firstscreen': (context) => FirstScreen(),
        '/results': (context) => ResultsPage(),
      },
    );
  }
}
