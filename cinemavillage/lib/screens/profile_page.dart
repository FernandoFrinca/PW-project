import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinemavillage/functionality/get_data.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  String? name = '';
  String? email = '';
  DateTime date_time = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      context: context,
    ).then((value) {
      setState(() {
        date_time = value!;
      });
    });
  }

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["username"];
          email = snapshot.data()!["email"];
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 66,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 241, 81, 37),
              Color.fromARGB(255, 25, 25, 25)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child:
                              Image.asset("assets/images/Cinema_village_2.png"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(400),
                            child: Image.asset(
                                fit: BoxFit.cover,
                                "assets/images/fernando.png"),
                          ), // aici vine cu api imagine adaugata
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText(name!, Icons.person_outline, 340)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText(email!, Icons.email_outlined, 340)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText(
                            '${date_time.day}/${date_time.month}/${date_time.year}',
                            Icons.calendar_month_outlined,
                            200),
                        const SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Container(
                            height: 50,
                            width: 130,
                            child: MaterialButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: _showDatePicker,
                              color: Colors.white38,
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'choose date',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText("gender", Icons.person_outline, 200)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
                   const SizedBox(
                      height: 40,
                    ),
                    printText(name!, Icons.person_outline),
                    const SizedBox(
                      height: 20,
                    ),
                    printText(email!, Icons.email),
                    const SizedBox(
                      height: 20,
                      ),
SizedBox(
                      width: 200,
                      child: reusablePrintTextField(
                          "Birthday", Icons.calendar_month_sharp),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: reusablePrintTextField(
                          "Gender", Icons.calendar_month_sharp),
                    
                    
                    
                    
                     Scaffold(
                      body: MaterialButton(
                        onPressed: _showDatePicker,
                        color: Colors.black,
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'choose Date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    
                    
                    
                    ),
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 340,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.person_outline, color: Colors.black),
                              Text(
                                name.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),*/