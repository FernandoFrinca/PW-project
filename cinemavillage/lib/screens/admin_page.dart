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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              //physics: const NeverScrollableScrollPhysics(),

              itemBuilder: (context, index) {
                return ListElementAdmin(
                  email: "Email: " + snapshot.data!.docs[index]['email'],
                  username: "User: " + snapshot.data!.docs[index]['username'],
                  document: snapshot.data!.docs[index]['uID'],
                  type: snapshot.data!.docs[index]['isAdmin'],
                  curentUser: _isAdmin,
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
