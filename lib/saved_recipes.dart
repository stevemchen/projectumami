import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:umami/RecipeIDPage.dart';

// class SavedRecipePage extends StatefulWidget {
//   final List<String> recipes = getDocs();
//   @override
//   _SavedRecipePageState createState() => _SavedRecipePageState();
// }

class SavedRecipePage extends StatelessWidget {
  @override
  Widget widg() {
    return FutureBuilder(
        future: getDocs(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            print("error");
          } else {
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data[index].get('title');
                    return Dismissible(
                        key: Key(item),
                        onDismissed: (direction) {
                          snapshot.data.removeAt(index);
                          FirebaseFirestore.instance.runTransaction(
                              (Transaction myTransaction) async {
                            await myTransaction.delete(snapshot
                                .data
                                .documents[index]
                                .reference); //need to fix item not deleting from databse
                          });
                        },
                        child: ListTile(
                          leading: Icon(Icons.fastfood),
                          title: Text('${snapshot.data[index].get('title')}'),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return RecipeIdPageMain(
                                  image: snapshot.data[index].get('image'),
                                  id: snapshot.data[index].get('id'),
                                  title: snapshot.data[index].get('title'));
                            }));
                          },
                        ));
                  }),
            );
          }
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Recipes'),
      ),
      body: widg(),
    );
  }
}

Future<List> getDocs() async {
  List documents = new List();
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("saved_recipes").get();
  for (int i = 0; i < querySnapshot.docs.length; i++) {
    var a = querySnapshot.docs[i];
    // documents.add(a.get('title'));
    documents.add(a);
  }
  return documents;
}
