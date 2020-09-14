import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Private methods within build method help us to
    // organize our code and recognize structure of widget
    // that we're building:
    Text _buildText() {
      return Text(
        'Welcome to Umami',
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildText(),
            // Space between "Recipes" and the button:
            SizedBox(height: 50.0),
            MaterialButton(
              color: Colors.white,
              child: Text("Sign In with Google"),
              onPressed: () => print("Button pressed."),
            )
          ],
        ),
      ),
    );
  }
}
