import 'dart:io';
import 'package:flutter/material.dart';
import 'package:umami/ui/screens/theme.dart';
import 'package:app_settings/app_settings.dart';

import 'Sidebar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Umami',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          backgroundColor: PrimaryColor,
          elevation: 0.0,
        ),
        drawer: SideBar(),
        body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
//          Container(
//            height: 50,
//            child: const Center(
//              child: Text(
//                'Change Notification Settings',
//                style: TextStyle(
//                    fontSize: 24,
//                    fontWeight: FontWeight.normal,
//                    letterSpacing: 1),
//              ),
//            ),
//          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    onPressed: () {
                      AppSettings.openNotificationSettings();
                    },
                    child: Text('Change Notification Settings',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )))
              ]),
          Container(
              height: 50,
              child: const Center(
                child: Text(
                  'Version Number: v0.1',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1),
                ),
              ))
        ]));
  }
}
