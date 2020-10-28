import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../sign_in.dart';
import 'first_screen.dart';
import 'package:umami/ui/screens/login.dart';
import 'package:umami/app.dart';
import 'package:umami/ui/screens/theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Umami'),
        backgroundColor: PrimaryColor,
        elevation: 0.0,
      ),
      body: Text('SETTINGS'),
    );
  }
}


