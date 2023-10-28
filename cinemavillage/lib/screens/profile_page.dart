import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinemavillage/screens/signIn_screen.dart';
import 'package:cinemavillage/screens/edit_page.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  String? name = '';
  String? email = '';
  String? gender = '';
  Timestamp? date_time = null;
  DateTime? birthday = null;
  String? image = '';

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
          gender = snapshot.data()!["gender"];
          date_time = snapshot.data()!["birthday"];
          birthday = date_time?.toDate();
          image = snapshot.data()!["userImage"];
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: Image.asset(
                              'assets/images/Cinema_village_N1.png'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.black54,
                              child: CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(image!),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText(
                          name!,
                          Icons.person_outline,
                          MediaQuery.of(context).size.width * 0.80,
                          MediaQuery.of(context).size.height * 0.062,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText(
                          email!,
                          Icons.email_outlined,
                          MediaQuery.of(context).size.width * 0.80,
                          MediaQuery.of(context).size.height * 0.062,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText(
                          '${birthday?.day}/${birthday?.month}/${birthday?.year}',
                          Icons.calendar_month_outlined,
                          MediaQuery.of(context).size.width * 0.80,
                          MediaQuery.of(context).size.height * 0.062,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        printText(
                          gender!,
                          Icons.people_outline_outlined,
                          MediaQuery.of(context).size.width * 0.80,
                          MediaQuery.of(context).size.height * 0.062,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(130, 40),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Edit_screen()));
                          },
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                                color: Color.fromARGB(255, 241, 81, 37)),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(130, 40),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                color: Color.fromARGB(255, 241, 81, 37)),
                          ),
                        ),
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
