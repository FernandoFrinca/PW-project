// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Admin_screen extends StatefulWidget {
  const Admin_screen({super.key});

  @override
  State<Admin_screen> createState() => _Admin_screen();
}

// ignore: camel_case_types
class _Admin_screen extends State<Admin_screen> {
  @override
  int _isAdmin = 0;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          _isAdmin = snapshot.data()!["isAdmin"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  Future<void> _deleteComment(String movieId, String comment) async {
    DocumentReference movieDoc =
        FirebaseFirestore.instance.collection('movies').doc(movieId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(movieDoc);

      if (!snapshot.exists) {
        throw Exception("Document does not exist!");
      }

      List<dynamic> updatedComments = List.from(snapshot['userComent']);
      updatedComments.remove(comment);

      transaction.update(movieDoc, {'userComent': updatedComments});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 25, 25),
        title: SizedBox(
          width: 270,
          height: 100,
          child: Image.asset('assets/images/Cinema_village_N1.png'),
        ),
        toolbarHeight: 65,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              title: const Text('Users List'),
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs
                            .map<Widget>((DocumentSnapshot document) {
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ListElementAdmin(
                              email: "Email: " + document['email'],
                              username: "User: " + document['username'],
                              document: document['uID'],
                              type: document['isAdmin'],
                              curentUser: _isAdmin,
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('All Comments'),
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("movies")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> commentWidgets = [];
                      for (var doc in snapshot.data!.docs) {
                        var movieComments =
                            List<String>.from(doc['userComent'] ?? []);
                        var movieId = doc.id;
                        commentWidgets
                            .addAll(movieComments.map((comment) => Card(
                                  margin: EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(comment),
                                    trailing: IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () =>
                                          _deleteComment(movieId, comment),
                                    ),
                                  ),
                                )));
                      }
                      return Column(children: commentWidgets);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
