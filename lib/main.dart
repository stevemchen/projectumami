import 'package:flutter/material.dart';
import 'dart:io';
import 'package:umami/app.dart';
import 'package:umami/client/hive_names.dart';
import 'package:umami/models/user_model.dart';
import 'package:umami/app.dart';
import 'package:umami/ui/screens/results.dart';
import 'package:umami/ui/screens/first_screen.dart';
import 'ui/screens/login.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<User_Model>(HiveBoxes.user);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
