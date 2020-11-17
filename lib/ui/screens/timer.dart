import 'package:umami/ui/screens/theme.dart';
import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:umami/DropDown.dart';
import 'package:umami/RecipeIDPage.dart';
import 'package:umami/models/Search.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:umami/ui/screens/theme.dart';
import 'package:toast/toast.dart';
import 'package:umami/Sidebar.dart';
import 'package:numberpicker/numberpicker.dart';


class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
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
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t) {
      setState(() {
        if (time < 1 || checktimer == false){
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
          int s = time - (60 *m);
          displaytime = m.toString() + ':' + s.toString();
          time = time - 1;
        } else {
          int h = time ~/ 3600;
          int t = time - (3600 * h);
          int m = t ~/60;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Row(
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
          ),
          Expanded(
            flex: 1,
            child: Text(
              displaytime,
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: started ? start: null,
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
          ),
        ],
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
      body: timer(),
    );
  }
}