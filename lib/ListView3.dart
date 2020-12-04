import 'package:flutter/material.dart';
import 'package:umami/services/User2.dart';
import 'package:umami/services/User_service2.dart';

class ListView3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ListViewPage(), theme: ThemeData(fontFamily: 'Nunito'));
  }
}

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<User2> _users2;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    User2Service.getUser().then((onValue) {
      _users2 = onValue;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(_loading ? 'ListView Json Loading....' : 'List of User'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: null == _users2 ? 0 : _users2.length,
              itemBuilder: (context, index) {
                User2 user2 = _users2[index];
                return Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 5)
                  ]),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ID: ${user2.id.toString()}'),
                          Divider(
                            thickness: 0.5,
                          ),
                          Text('Name: ${user2.name}'),
                          Text('Username: ${user2.username}'),
                          Text('Email: ${user2.email}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Street: ${user2.address.street}'),
                              Text('Suite: ${user2.address.suite}'),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('City: ${user2.address.city}'),
                              Text(
                                  'ZipCode: ${user2.address.zipcode.toString()}'),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                          ),
                          Text('Geo lat: ${user2.address.geo.lat}',
                              style: TextStyle(color: Colors.grey)),
                          Text('Geo lng: ${user2.address.geo.lng}',
                              style: TextStyle(color: Colors.grey)),
                          Text(
                              'Phone: ${user2.phone}\nEmail: ${user2.email}\nCompany name: ${user2.company.name}\nCompany CatchPhrase: ${user2.company.catchPhrase}',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
