import 'package:flutter/material.dart';

class Listview1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ListView1Page(), theme: ThemeData(fontFamily: 'Nunito'));
  }
}

class ListView1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ListView'),
        ),
        body: ListView.builder(
          itemCount: wonders.length,
          itemBuilder: (context, index) {
            return Column(children: <Widget>[
              ListTile(
                title: Text('Name: ${wonders[index].name}'),
                subtitle: Text('Country: ${wonders[index].country}'),
                leading: Image.network('${wonders[index].imageUrl}',
                    width: 60, height: 60),
              ),
              Divider(
                  thickness: 1, height: 1, color: Colors.grey.withOpacity(.2))
            ]);
          },
        ));
  }
}

class Place {
  String imageUrl;
  String name;
  String country;

  Place({this.imageUrl, this.name, this.country});
}

List wonders = [
  Place(
      imageUrl:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Taj-Mahal.jpg",
      name: "Taj Mahal",
      country: "India"),
  Place(
      imageUrl:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Christ-the-Redeemer.jpg",
      name: "Christ the Redeemer",
      country: "Brazil"),
  Place(
      imageUrl:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2016/03/petra-jordan9.jpg",
      name: "Petra",
      country: "Jordan"),
  Place(
      imageUrl:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Great-Wall-of-China-view.jpg",
      name: "The Great Wall of China",
      country: "China"),
  Place(
      imageUrl:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/View-of-the-Colosseum.jpg",
      name: "The Colosseum",
      country: "Rome"),
  Place(
      imageUrl:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
      name: "Machu Picchu",
      country: "Peru"),
  Place(
      imageUrl:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Chichen-Itza-at-night.jpg",
      name: "Chichén Itzá",
      country: "Mexico"),
];
