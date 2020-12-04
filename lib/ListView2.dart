import 'package:flutter/material.dart';
import 'package:umami/services/User.dart';
import 'package:umami/services/User_Service.dart';

class ListView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ListView2Page(), theme: ThemeData(fontFamily: 'Nunito'));
  }
}

class ListView2Page extends StatefulWidget {
  @override
  _ListView2PageState createState() => _ListView2PageState();
}

class _ListView2PageState extends State<ListView2Page> {
  List<User> _users;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    UserService.getUser().then((onValue) {
      _users = onValue;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_loading ? 'Loading....' : 'Users'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
            child: ListView.builder(
                itemCount: null == _users ? 0 : _users.length,
                itemBuilder: (context, index) {
                  User user = _users[index];
                  return Column(children: <Widget>[
                    ListTile(
                        title:
                            Text('UserID: ${user.userId} --- ID: ${user.id}'),
                        subtitle:
                            Text('Title: ${user.title}\nBody: ${user.body}')),
                    Divider(
                      thickness: 2,
                    )
                  ]);
                })));
  }
}
