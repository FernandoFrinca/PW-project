import 'package:cinemavillage/screens/Main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:cinemavillage/screens/home_screen.dart';
import 'package:cinemavillage/screens/sinUp_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 241, 81, 37), 
          const Color.fromARGB(255, 25, 25, 25)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/Cinema_village_2.png", 300, 240),
                reusableTextField("Your email", Icons.person_outline, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outline, true, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                singInSingUpButton(context, true, () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text, 
                    password: _passwordTextController.text).then((value) {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => Main_screen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  
                }),
                signUpOption(),
                
                
                
              ],
            ),
          ),
        ),
      ),
       
    );
  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
  
  

}