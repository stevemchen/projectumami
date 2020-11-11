// import 'dart:html';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../sign_in.dart';
import 'first_screen.dart';
import 'package:umami/ui/screens/login.dart';
import 'package:umami/ui/screens/theme.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  Widget cardTemplate() {
    return RecipeCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Umami'),
        backgroundColor: PrimaryColor,
        elevation: 0.0,
      ),
      drawer: Drawer(
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Saved Recipes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Timers'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('History'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Shopping List'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              alignment: Alignment(-1,0),
              child: FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) {return FirstScreen();}
                    ),
                  );
                },
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) {return LoginPage();}
                  ),
                );
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('Sign Out'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
          children: [
            Container(
              height: (60.0),
              decoration: BoxDecoration(
                color: PrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              right: 10,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: PrimaryColor.withOpacity(0.5),
                            ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                RecipeCard(),
                RecipeCard(),
                RecipeCard(),
                RecipeCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Time and Difficulty',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Missing Ingredients',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          Container(
            color: Colors.cyan,
            padding: EdgeInsets.all(30),
            child: Text('Image here'),
          ),
        ],
      ),
    );
  }
}

