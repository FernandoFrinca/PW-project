import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:cinemavillage/screens/Main_page.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  DateTime _date_time = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future addUserDetails(
    String mail,
    String pass,
    String user_name,
    String _uid,
    DateTime _birthday,
    String _gender,
    String _image,
    List<String> _favorites,
  ) async {
    await FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'email': mail,
      'password': pass,
      'username': user_name,
      'uID': _uid,
      'birthday': _birthday,
      'gender': _gender,
      'userImage': _image,
      'favorites': _favorites,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Color.fromARGB(255, 255, 255, 255), // <-- SEE HERE
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 241, 81, 37),
            Color.fromARGB(255, 25, 25, 25)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                singInSingUpButton(context, false, () {
                  _auth
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    final User? user = _auth.currentUser;
                    final _uid = user!.uid;
                    addUserDetails(
                      _emailTextController.text.trim(),
                      "",
                      _userNameTextController.text.trim(),
                      _uid,
                      _date_time,
                      'none',
                      'https://firebasestorage.googleapis.com/v0/b/cinemavillage-8844e.appspot.com/o/userImages%2Fuser.jpg?alt=media&token=9c71e381-526b-4eb9-9c62-1247bbef901c&_gl=1*87droy*_ga*ODM2NzA1OTg0LjE2OTcxMjA1ODU.*_ga_CW55HF8NVT*MTY5Nzk5MDk4MS4yMi4xLjE2OTc5OTEwMjEuMjAuMC4w',
                      [],
                    );
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Main_screen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ))),
    );
  }
}
