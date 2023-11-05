import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:cinemavillage/screens/Main_page.dart';
import 'package:cinemavillage/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class favorites_screen extends StatefulWidget {
  const favorites_screen({super.key});

  @override
  State<favorites_screen> createState() => _favorites_screen();
}

class _favorites_screen extends State<favorites_screen> {
  List? favorites = null;
  List<String> titles = [];
  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(() {
            favorites = snapshot.data()!["favorites"];
          });
        }
        titles = favorites!.map((element) => element.toString()).toList();
        titles.sort();
        print(titles);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 25, 25),
        title: SizedBox(
          width: 270,
          height: 100,
          child: Image.asset('assets/images/Cinema_village_N1.png'),
        ),
        toolbarHeight: 65,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return ListElement(child: titles[index]);
        },
      ),
    );
  }
}
