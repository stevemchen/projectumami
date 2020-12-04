import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:umami/RecipeIDPage.dart';
import 'package:umami/models/Search.dart';
import 'package:umami/ui/screens/theme.dart';
import 'package:umami/Sidebar.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:toast/toast.dart';

class SearchRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //dropbox key
    final navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
        home: DropdownBanner(
            child: SearchRecipePage(), navigatorKey: navigatorKey),
        theme: ThemeData(
          fontFamily: 'Nunito',
          accentColor: PrimaryColor,
        ));
  }
}

class SearchRecipePage extends StatefulWidget {
  @override
  _SearchRecipePageState createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  final europeanCountries = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium',
    'Bosnia and Herzegovina',
    'Bulgaria',
    'Croatia',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Estonia',
    'Finland',
    'France',
    'Georgia',
    'Germany',
    'Greece',
    'Hungary',
    'Iceland',
    'Ireland',
    'Italy',
    'Kazakhstan',
    'Kosovo',
    'Latvia',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macedonia',
    'Malta',
    'Moldova',
    'Monaco',
    'Montenegro',
    'Netherlands',
    'Norway',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'San Marino',
    'Serbia',
    'Slovakia',
    'Slovenia',
    'Spain',
    'Sweden',
    'Switzerland',
    'Turkey',
    'Ukraine',
    'United Kingdom',
    'Vatican City'
  ];
  //dropdown
  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {});
  }

  //key for scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controller = TextEditingController();
  final _controllerScroll = new ScrollController();
  //url
  String query = "";
  int itemSize = 100;
  int offset = 0;
  String message = '';
  var response;
  bool _isColorTile = false;
  int _positionTile = 0;

  final String baseUrl = 'https://api.spoonacular.com/recipes/search?query=';
  final String key = "&apiKey=46b60620dcee4f78aba8730bd9f9fcae";
  String url = "";
  String url2;
  String number = "&number=";
  int numberValue = 10;

  bool isEndScroll = false;
  //is find button to change gradient color
  bool isFindButton = true;
  // count total result after change textfield
  bool isClickable = true;

  //dialog title value
  String _dialogValue;

  //focus node to hide/show keyboard
  final focusNode = FocusNode();

  int totalResult = 10;
  Future<Search> futureSearch;
//build Color value
  _scrollListener() {
    if (_controllerScroll.offset >=
            _controllerScroll.position.maxScrollExtent &&
        !_controllerScroll.position.outOfRange) {
      setState(() {
        print(message);
        isEndScroll = true;
        // _positionTile = _controllerScroll.position.maxScrollExtent.toInt(); => result =1084 wrong??
        _positionTile = 20;
        message = "reach the bottom + positionTile: $_positionTile";
      });
    }
    if (_controllerScroll.offset <=
            _controllerScroll.position.minScrollExtent &&
        !_controllerScroll.position.outOfRange) {
      setState(() {
        print(message);
        isEndScroll = false;
        _positionTile = _controllerScroll.position.minScrollExtent.toInt();
        message = "reach the top + positionTile: $_positionTile";
      });
    }
  }

  @override
  void initState() {
    print('init State');
    // futureSearch = _fecthSearch();
    // _fecthSearch();
    totalResult = 10;
    isClickable = true;

    _controllerScroll.addListener(_scrollListener);
    _controller.addListener(() {
      print("value: ${_controller.text}");
      setState(() {
        query = _controller.text;
        url = baseUrl + query + number + numberValue.toString() + key;
        print('value url: $url');
      });
    });

    //turn of keyboard
    //top snackbar

    //dropdown menu
    //focus node

    focusNode.unfocus();
    super.initState();
  }

  Future<Search> _fecthSearch() async {
    setState(() {
      url = baseUrl + _controller.text + number + numberValue.toString() + key;
    });
    if (totalResult < 10) {
      setState(() {
        isClickable = false;
      });
    } else {
      setState(() {
        isClickable = true;
      });
    }
    print('url search: $url');
    print('total Search: $totalResult');
    print('clickable: $isClickable');
    if (totalResult == 0) {
      print("dumbass");
      setState(() {
        isFindButton = false;
      });
    } else if (totalResult < 10) {
      setState(() {
        isFindButton = false;
      });
    } else {
      setState(() {
        isFindButton = true;
      });
    }

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Search.fromJson(json);
    } else {
      throw Exception('failed to load search recipe');
    }
  }

  Future<Search> _fecthSearch2() async {
    setState(() {
      url = baseUrl + _controller.text + number + numberValue.toString() + key;
    });
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Search.fromJson(json);
    } else {
      throw Exception('failed to load search recipe');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onSubmit() {
    setState(() {
      query = _controller.text;
      url = baseUrl + query + key;
    });
  }

  _onChange() {
    setState(() {
      query = _controller.text;
      url = baseUrl + query + key;
      print('query: $query');
    });
  }

  _moveDown() {
    offset = _controllerScroll.offset.toInt();
    _controllerScroll.animateTo(_controllerScroll.offset + itemSize,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    if (_controllerScroll.offset ==
        _controllerScroll.position.maxScrollExtent) {
      setState(() {
        print('end scroll');
        isEndScroll = true;
      });
    }
  }

  _moveUp() {
    _controllerScroll.animateTo(_controllerScroll.offset - itemSize,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    if (_controllerScroll.offset ==
        _controllerScroll.position.minScrollExtent) {
      setState(() {
        print('up scroll first item');
        isEndScroll = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: isEndScroll == false
          ? FloatingActionButton(
              backgroundColor: PrimaryColor,
              elevation: 5,
              child: Center(
                  child: Icon(Icons.arrow_downward,
                      color: Colors.white, size: 16)),
              onPressed: () {
                _moveDown();
              })
          : FloatingActionButton(
              backgroundColor: PrimaryColor,
              elevation: 5,
              child: Center(
                  child:
                      Icon(Icons.arrow_upward, color: Colors.white, size: 16)),
              onPressed: () {
                _moveUp();
              }),
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
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text('FOOD RECIPES',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              color: PrimaryColor),
                          child: Center(
                              child: Icon(Icons.search,
                                  size: 16, color: Colors.white))),
                      Container(
                          width:
                              MediaQuery.of(context).size.width - 50 - 10 - 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              border: Border.all(
                                color: Colors.grey.withOpacity(.4),
                                width: 1,
                              )),
                          child: TextField(
                              // onSubmitted: _onSubmit(),
                              // onChanged: _onChange(),
                              // focusNode: _focusNode(),
                              onChanged: (text) {
                                _fecthSearch();
                                setState(() {
                                  query = _controller.text;
                                  setState(() {
                                    numberValue = 10;
                                    url = baseUrl +
                                        query +
                                        number +
                                        numberValue.toString() +
                                        key;
                                  });
                                  //this code continue to get totalResult
                                });
                              },
                              //auto focus alway open soft keyboard when init page
                              controller: _controller,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              // maxLength: 20,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.arrow_drop_down),
                                      onPressed: () {
                                        _showDropDown(context);
                                      }),
                                  // helperText: 'Search Recipe',
                                  hintText: 'Search Recipe here',
                                  hintMaxLines: 1,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.4),
                                      fontSize: 15)))),
                    ],
                  )),
              Stack(children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 122,
                  padding: EdgeInsets.only(bottom: 40),
                  width: double.infinity,
                  child: FutureBuilder(
                    future: _fecthSearch(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Search search = snapshot.data;
                        totalResult = search.totalResults;
                        if (totalResult == 0) {
                          return Center(
                              child: Text(
                            "Wow you managed to return 0 results. That's pretty impressive. Please search again with less ingredients",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.red),
                          ));
                        }

                        return ListView.builder(
                            itemCount: search.result.length,
                            controller: _controllerScroll,
                            // itemExtent: search.result.length.toDouble()+65,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  InkWell(
                                    splashColor: Colors.blue,
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return RecipeIdPageMain(
                                            image: search.baseUri +
                                                search.result[index].image
                                                    .toString(),
                                            id: search.result[index].id,
                                            title: search.result[index].title);
                                      }));
                                    },
                                    child: Container(
                                      child: ListTile(
                                          //hero
                                          leading: Hero(
                                            tag: search.baseUri +
                                                search.result[index].image,
                                            child: Container(
                                                height: 50,
                                                width: 50,
                                                child: Image.network(
                                                    search.baseUri +
                                                        search.result[index]
                                                            .image)),
                                          ),
                                          subtitle: Text(
                                              'Servings: ${search.result[index].servings}    Prep Time: ${search.result[index].readyInMinutes} min'),
                                          title: Text(
                                              ' ${search.result[index].title}')),
                                    ),
                                  ),
                                  Divider(color: Colors.blue.shade400),
                                ],
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('An error ocur: ${snapshot.error}'));
                      }
                      return Center(
                        child: Container(
                            height: 50,
                            width: 50,
                            child: new SpinKitCubeGrid(
                              color: Colors.blue.shade200,
                            )),
                      );
                    },
                  ),
                ),
                Positioned(
                    bottom: 50,
                    child: GestureDetector(
                      onTap: isClickable
                          ? () {
                              //use toast
                              //use dropdown banner
                              DropdownBanner.showBanner(
                                text: 'Load more 10 Recipe!',
                                color: Colors.blue.shade400,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              );

                              //use scaffold snackbar
                              // _useScaffoldSnackbar();
                              //or use Toast
                              // _useToast();
                              setState(() {
                                numberValue = numberValue + 10;
                                url = baseUrl +
                                    query +
                                    number +
                                    numberValue.toString() +
                                    key;
                              });
                              print(
                                  'Load more 10+ recipe +$isClickable+$numberValue');
                            }
                          : null,
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            gradient: isFindButton == true
                                ? LinearGradient(
                                    colors: [PrimaryColor, PrimaryColor])
                                : LinearGradient(colors: [
                                    Colors.red.shade600,
                                    Colors.red.shade200
                                  ])),
                        child: Container(
                            child: Center(
                                child: Text('find more 10+',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)))),
                      ),
                    ))
              ]),
            ],
          ),
        ),
      ),
    );
  }

  //row search video
  _buildItemRow(
      {String title, Color color, IconData icon, BuildContext context}) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPage()));
      },
      child: Container(
          margin: EdgeInsets.only(right: 10),
          height: 35,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.blue.shade300,
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 31,
                    width: 31,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Icon(icon, color: Colors.white, size: 12))),
                SizedBox(
                  width: 5,
                ),
                Text(title,
                    style: TextStyle(color: Colors.black54, fontSize: 14))
              ],
            ),
          )),
    );
  }

  _useScaffoldSnackbar() {
    return _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: new DecoratedBox(
        decoration: BoxDecoration(),
        child: Text('Load more 10 recipe'),
      ),
      duration: Duration(seconds: 3),
    ));
  }

  _useToast() {
    return Toast.show("load more 10 recipe", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  //show dropdown
  _showDropDown(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (_)=>DropDown()));
    print('show dropdown button');

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 100,
              height: 250,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Expanded(
                    child: ListView.builder(
                        itemCount: europeanCountries.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _dialogValue = europeanCountries[index];
                                      focusNode.unfocus();

                                      //set for controller
                                      _controller.text = _dialogValue;
                                    });
                                    print(
                                        'dialog value title: $_dialogValue dialog value controller text: ${_controller.text}');
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(europeanCountries[index])),
                              Divider(
                                color: Colors.blue.shade400,
                              )
                            ],
                          );
                        }))
              ]),
            ),
          );
        });
  }
}

class Company {
  String name;
  Company(this.name);
  static List<Company> getCompanies() {
    return <Company>[
      Company('Apple'),
      Company('Google'),
      Company('Samsung'),
      Company('Sony'),
      Company('LG'),
    ];
  }
}
