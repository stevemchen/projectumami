import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umami/ui/screens/theme.dart';
import 'Sidebar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  String name = 'User';
  String email = 'email@domain.com';
  String tempFirst, tempLast, tempEmail;
  final picker = ImagePicker();

  Future getImage() async {
    final picked = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (picked != null) {
        _image = File(picked.path);
      } else {
        _image = File('assets/defaultuser.jpg');
      }
    });
  }

  set image(File image) {
    this._image = image;
  }

  get profileImage => _image;

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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 65,
                  backgroundImage: _image == null
                      ? AssetImage('assets/defaultuser.jpg')
                      : FileImage(_image),
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                Text(
                  email,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1),
                ),
                SizedBox(
                    height: 20,
                    width: 250,
                    child: Divider(
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    onSubmitted: (String value) async {
                      tempFirst = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    onSubmitted: (String value) async {
                      tempLast = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSubmitted: (String value) async {
                      tempEmail = value;
                    },
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                          onPressed: () {
                            setState(() {
                              update();
                            });
                          },
                          child: Text('Change Information',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )))
                    ])
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ));
  }

  void update() {
    name = tempFirst + ' ' + tempLast;
    email = tempEmail;
  }
}
