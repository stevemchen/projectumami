import 'package:umami/ui/screens/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:umami/ui/screens/theme.dart';
import 'package:umami/Sidebar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../notification_helper.dart';

class TimerPage extends StatefulWidget {
  final String payload;

  const TimerPage({
    @required this.payload,
    Key key,
  }) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final notifications = FlutterLocalNotificationsPlugin();

  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TimerPage(payload: payload)),
      );

  @override
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int time = 0;
  String displaytime = "";
  bool checktimer = true;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    time = (hour * 60 * 60) + (min * 60) + sec;
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      setState(() {
        if (time < 1 || checktimer == false) {
          showOngoingNotification(notifications,
              title: 'Umami', body: 'The timer is up');
          t.cancel();
          checktimer = true;
          displaytime = "";
          started = true;
          stopped = true;
        } else if (time < 60) {
          displaytime = time.toString();
          time = time - 1;
        } else if (time < 3600) {
          int m = time ~/ 60;
          int s = time - (60 * m);
          displaytime = m.toString() + ':' + s.toString();
          time = time - 1;
        } else {
          int h = time ~/ 3600;
          int t = time - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          displaytime = h.toString() + ':' + m.toString() + ':' + s.toString();
          time = time - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
    });
  }

  void delete() {
    //TODO add seperate stop/ delete buttons
  }

  Widget timer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Hr',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      maxValue: 23,
                      listViewWidth: 60.0,
                      onChanged: (val) {
                        setState(() {
                          hour = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Min',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 60,
                      listViewWidth: 60.0,
                      onChanged: (val) {
                        setState(() {
                          min = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Sec',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 60,
                      listViewWidth: 60.0,
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                displaytime,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: started ? start : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: PrimaryColor,
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'STOP',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: PrimaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          timer(),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle,
              size: 30.0,
            ),
            label: Text('Add a timer'),
          ),
        ],
      ),
    );
  }
}
