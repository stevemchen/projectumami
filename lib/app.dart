import 'package:flutter/material.dart';
import 'package:umami/ui/screens/login.dart';
import 'package:umami/ui/screens/first_screen.dart';
import 'package:umami/ui/screens/results.dart';
import 'package:umami/ui/screens/theme.dart';
import 'package:umami/ui/screens/settings.dart';

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
        '/login': (context) => LoginPage(),
      },
    );
  }
}