import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:umami/models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProductInfor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ProductInforPage(), theme: ThemeData(fontFamily: 'Nunito'));
  }
}

class ProductInforPage extends StatefulWidget {
  @override
  _ProductInforPageState createState() => _ProductInforPageState();
}

class _ProductInforPageState extends State<ProductInforPage> {
  Future<Product> futureProduct;
  var length;

  //visible listview
  bool _visible = false;
  bool _visibleDes = false;
  bool _visibleIcon = false;
  bool _visibleIconUp = false;
  int clickCount = 0;
  int itemSizeExtend;

  //scroll controller for listview
  ScrollController _controller = new ScrollController();
  Future<Product> _fetchProduct() async {
    final url =
        "https://api.spoonacular.com/food/products/22347?apiKey=45eaba7f12a54861a03e0177818c82c0";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);

      setState(() {
        length = jsonRes.length;
        print('Product record length count: ${jsonRes.length} total');
      });
      return Product.fromJson(jsonRes);
    } else {
      throw Exception('failed to load product');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProduct = _fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Production Information')),
        body: Center(
          child: FutureBuilder(
            future: futureProduct,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Product product = snapshot.data;
                return ListView(
                  children: <Widget>[
                    Text('ID: ${product.id}'),
                    Divider(),
                    Text('Title: ${product.title}'),
                    Divider(),
                    Text('Prices: ${product.price}'),
                    Divider(),
                    Text(
                      'Likes: ${product.likes} \nServing-Side: ${product.serving_size} ',
                      style: TextStyle(height: 1.5),
                    ),
                    Divider(),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Description'),
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey, size: 15),
                              onPressed: () {
                                setState(() {
                                  print('click des $_visibleDes');
                                  _visibleFunDes();
                                });
                              })
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _visibleDes,
                      child: Text(
                        '${product.description}',
                        style: TextStyle(
                          height: 1.7,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Divider(),
                    Text('Ingredient Count: ${product.ingredientCount}'),
                    Divider(),
                    Text('Nutrition Information'),
                    Container(
                        height: 260,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('-Calories: ${product.nutrition.calories}'),
                            Text('-Fat: ${product.nutrition.fat}'),
                            Text('-Protein: ${product.nutrition.protein}'),
                            Container(
                                height: 20,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                10,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.3),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text('Title'),
                                        )),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.3),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text('Amount'),
                                        )),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.3),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text('percentOfDailyNeeds'),
                                        )),
                                  ],
                                )),
                            Container(
                                height: 175,
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Text(
                                                  '${product.nutrition.nutrients[index].title}')),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Text(
                                                  '${product.nutrition.nutrients[index].amount} ${product.nutrition.nutrients[index].unit}')),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Text(
                                                  '${product.nutrition.nutrients[index].percentOfDailyNeeds}')),
                                        ],
                                      );
                                    }))
                          ],
                        ))

                    /* Container(
                      width:double.infinity,
                      child: RichText(
                        text:TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:'Ingredient List:',style:TextStyle(color:Colors.black,fontFamily: 'Nunito')),
                            TextSpan(text:'${product.ingredientList}',style:TextStyle(color:Colors.grey,fontFamily: 'Nunito')),
                          ]
                        )
                      ),
                    ), */
                    ,
                    Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: product.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Image.network(
                              '${product.images[index].toString()}',
                            );
                          }),
                    ),
                    Divider(),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Ingredient Infor'),
                            InkWell(
                              splashColor: Colors.blue,
                              focusColor: Colors.blue,
                              child: Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    _visibleIconUp == true
                                        ? IconButton(
                                            icon: Icon(Icons.arrow_upward,
                                                color: Colors.black45),
                                            onPressed: () {
                                              _moveDown();
                                              _controller.animateTo(
                                                  _controller.offset -
                                                      product.ingredients.length
                                                          .toDouble(),
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve:
                                                      Curves.linearToEaseOut);

                                              if (_controller.offset ==
                                                  _controller.position
                                                      .minScrollExtent) {
                                                print('min item reach');
                                                setState(() {
                                                  _visibleIcon = true;
                                                  _visibleIconUp = false;
                                                });
                                              }
                                            })
                                        : Container(height: 0, width: 0),
                                    _visibleIcon
                                        ? IconButton(
                                            icon: Icon(Icons.arrow_downward,
                                                color: Colors.black45),
                                            onPressed: () {
                                              _moveDown();
                                              _controller.animateTo(
                                                  _controller.offset +
                                                      product.ingredients.length
                                                          .toDouble(),
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve:
                                                      Curves.linearToEaseOut);

                                              if (_controller.offset ==
                                                  _controller.position
                                                      .maxScrollExtent) {
                                                print('max item reach');
                                                setState(() {
                                                  _visibleIcon = false;
                                                  _visibleIconUp = true;
                                                });
                                              }
                                            })
                                        : Container(height: 0, width: 0),
                                    Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(.6),
                                                blurRadius: 10,
                                              )
                                            ]),
                                        child: IconButton(
                                            icon: Icon(Icons.arrow_forward_ios,
                                                size: 15, color: Colors.grey),
                                            onPressed: () {
                                              /* print('click hide button');
                                  setState(() {
                                    _visible = true;
                                  }); */
                                              _visibleFun();
                                            })),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Visibility(
                      visible: _visible,
                      child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: ListView.builder(
                              itemCount: product.ingredients.length,
                              controller: _controller,
                              itemExtent: product.ingredients.length.toDouble(),
                              itemBuilder: (context, index) {
                                return new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(.3))),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Text(
                                            '${product.ingredients[index].name}',
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    product.ingredients[index].safety_level !=
                                            null
                                        ? Text(
                                            '-Safety: ${product.ingredients[index].safety_level}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10))
                                        : Container(height: 0, width: 0),
                                    product.ingredients[index].description !=
                                            null
                                        ? Text(
                                            '-Description: ${product.ingredients[index].description}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10))
                                        : Container(height: 0, width: 0),
                                    Container(
                                        color: Colors.blue.withOpacity(.3),
                                        height: .5,
                                        width: double.infinity),
                                  ],
                                );
                              })),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return new Text('An Error Occur: ${snapshot.error}');
              }
              return SpinKitThreeBounce(color: Colors.blue.shade200);
            },
          ),
        ));
  }

  void _moveDown() {}
  void _visibleFun() {
    setState(() {
      clickCount++;
      if (clickCount % 2 == 0) {
        print('so chan $clickCount set visible is false/off');
        _visible = false;
        _visibleIcon = false;
      } else {
        print('so le $clickCount set visible is true/on');
        _visible = true;
        _visibleIcon = true;
      }
    });
  }

  void _visibleFunDes() {
    setState(() {
      clickCount++;
      if (clickCount % 2 == 0) {
        print('so chan $clickCount set visible is false/off');
        _visibleDes = false;
      } else {
        print('so le $clickCount set visible is true/on');
        _visibleDes = true;
      }
    });
  }
}
