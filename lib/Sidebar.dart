// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umami/ProfilePage.dart';
import 'package:umami/saved_recipes.dart';
import 'package:umami/Settings.dart';
import 'package:umami/search_recipe.dart';
// import '../../sign_in.dart';
import 'package:umami/ui/screens/login.dart';
import 'package:umami/ui/screens/theme.dart';
import 'package:umami/ui/screens/timer.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/defaultuser.jpg'),
                  radius: 50,
                ),
                Container(
                  alignment: Alignment(1.0, -1.0),
                  child: Text(
                    'U',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: PrimaryColor,
            ),
          ),
          ListTile(
            title: Text('My Account'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ProfilePage();
                }),
              );
            },
          ),
          ListTile(
            title: Text('Search Recipes'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return SearchRecipePage();
                }),
              );
            },
          ),
          ListTile(
            title: Text('Saved Recipes'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return SavedRecipePage();
                }),
              );
            },
          ),
          ListTile(
            title: Text('Timers'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return TimerPage();
                }),
              );
            },
          ),
          Container(
            alignment: Alignment(-1, 0),
            child: FlatButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return SettingsPage();
                  }),
                );
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }),
              );
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
