import 'dart:async';

import 'package:flutter/material.dart';

class ListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ListDemoPage(), theme: ThemeData(fontFamily: 'Nunito'));
  }
}

class ListDemoPage extends StatefulWidget {
  @override
  _ListDemoPageState createState() => _ListDemoPageState();
}

class _ListDemoPageState extends State<ListDemoPage> {
  ScrollController _controller = new ScrollController();
  //
  String message = "Notification here";
  int itemSize = 31;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollController);
    super.initState();
  }

  _scrollController() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        _controller.position.outOfRange) {
      setState(() {
        message = 'reach bottom list';
        print('reach bottom list');
      });
      if (_controller.offset <= _controller.position.minScrollExtent &&
          _controller.position.outOfRange) {
        setState(() {
          message = 'reach top list ';
          print('reach top list');
        });
      }
    }
  }

  _moveFirst() {
    setState(() {
      message = 'move first item position';
    });
    _controller.animateTo(_controller.offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticInOut);
  }

  _moveLast() {
    setState(() {
      message = 'move last item position';
    });
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  _moveUp() {
    setState(() {
      message = 'move up 1 item';
    });
    if (_controller.offset == _controller.position.minScrollExtent) {
      setState(() {
        message = "top list - first item";
      });
    }
    _controller.animateTo(_controller.offset - itemSize,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  _moveDown() {
    setState(() {
      message = 'move down 1 item';
    });
    if (_controller.offset == _controller.position.maxScrollExtent) {
      setState(() {
        message = 'end list - last item';
      });
    }
    _controller.animateTo(_controller.offset + itemSize,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    // Timer(Duration(milliseconds: 1000), () => _controller.jumpTo(_controller.position.maxScrollExtent));
    return Scaffold(
      appBar: AppBar(title: Text('ListView demo')),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(message,
                  style: TextStyle(color: Colors.black.withOpacity(.5))),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          _moveUp();
                        },
                        child: Text('Up')),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          _moveFirst();
                        },
                        child: Text('1st item')),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          _moveLast();
                        },
                        child: Text('last item')),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          _moveDown();
                        },
                        child: Text('Down')),
                  ],
                ),
              ),
              new Center(
                  child: new Container(
                width: double.infinity,
                height: 400.0,
                child: new Column(
                  children: [
                    new Flexible(
                        /* child: new ListView(
                          controller: _controller,
                          reverse: true,
                          shrinkWrap: true,
                          children: <Widget>[
                             new ListTile(title: Text(_messages.toString())),
                          ],
                        ), */
                        child: new ListView.builder(
                      // reverse: true, // revert list direction top and bottom
                      controller: _controller,
                      itemCount: 30,
                      itemExtent: itemSize.toDouble(),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                          ),
                          child: Center(
                            child: Text("ListTile $index"),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),

      /* floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      message= 'move to first item';
                      _controller.animateTo(_controller.position.minScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    });
                  },
                  child: Icon(Icons.navigate_before),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
            _messages.insert(0, new Text("message ${_messages.length}"));
            message = "move to last item";
          });
                    _controller.animateTo(
            _controller.position.maxScrollExtent,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300)
          );
                  },
                  child: Icon(Icons.navigate_next),
                )
              ],
            ),
          ), */
    );
  }
}
