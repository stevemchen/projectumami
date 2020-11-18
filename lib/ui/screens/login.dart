import 'package:flutter/material.dart';
import 'package:umami/RecipeIDPage.dart';
// import 'package:umami/models/Food.dart';
import 'package:umami/search_recipe.dart';
import 'package:umami/ui/screens/RecipeListView.dart';
import 'package:umami/ui/screens/meals_screen.dart';
import 'package:umami/ui/screens/recipe_screen.dart';
import 'package:umami/ui/screens/search_screen.dart';
import '../../sign_in.dart';
import 'first_screen.dart';
import 'package:umami/app.dart';
import 'package:umami/ui/screens/login.dart';
import 'package:umami/ui/screens/first_screen.dart';
import 'package:umami/ui/screens/results.dart';
import 'package:umami/ui/screens/theme.dart';
import 'package:umami/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    BoxDecoration _buildBackground() {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/wp5289083.jpg"),
          fit: BoxFit.cover,
        ),
      );
    }

    Text _buildText() {
      return Text(
        'Umami',
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.start,
      );
    }

    return Scaffold(
      body: Container(
        decoration: _buildBackground(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 120),
              _buildText(),
              SizedBox(height: 375),
              _signInButton(),
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {return SearchRecipe();}
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward),
                label: Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.blue,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          }
        });
        // dbSave();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
