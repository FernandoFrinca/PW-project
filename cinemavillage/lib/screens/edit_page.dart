import 'package:cinemavillage/screens/Main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';

class Edit_screen extends StatefulWidget {
  const Edit_screen({super.key});

  @override
  State<Edit_screen> createState() => _Edit_screen();
}

class _Edit_screen extends State<Edit_screen> {
  TextEditingController _userNameTextController = TextEditingController();

  //String returnedTextField = '';
  String? name = '';
  //String? email = '';
  String? gender = 'none';
  Timestamp? date_time = null;
  DateTime? birthday = null;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["username"];
          //email = snapshot.data()!["email"];
          gender = snapshot.data()!["gender"];
          date_time = snapshot.data()!["birthday"];
          birthday = date_time?.toDate();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  int _genderValue = 0;
  void _showDatePicker() {
    showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      context: context,
    ).then((value) {
      setState(() {
        birthday = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 241, 81, 37),
          Color.fromARGB(255, 25, 25, 25)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/images/Cinema_village_2.png"),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.black54,
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage("assets/images/fernando.png"),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              updateText(name!, Icons.edit, _userNameTextController),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 0,
                  ),
                  printText(
                      '${birthday?.day}/${birthday?.month}/${birthday?.year}',
                      Icons.calendar_month_outlined,
                      210,
                      60),
                  const SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: Container(
                      height: 60,
                      width: 141,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  printText(
                      "Select gender:", Icons.people_outline_outlined, 140, 55),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Radio(
                            value: 1,
                            groupValue: _genderValue,
                            onChanged: (value) {
                              setState(() {
                                _genderValue = value!;
                                gender = "Male";
                              });
                            }),
                        const Text(
                          "Male",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Radio(
                            value: 2,
                            groupValue: _genderValue,
                            onChanged: (value) {
                              setState(() {
                                _genderValue = value!;
                                gender = "Female";
                              });
                            }),
                        const Text(
                          "Female",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 50)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                    child: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 50)),
                    onPressed: () {
                      if (_userNameTextController.value.text != '') {
                        name = _userNameTextController.value.text;
                      }
                      final docUser = FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid);
                      docUser.update({
                        'username': name,
                        'gender': gender,
                        'birthday': birthday,
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Main_screen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

 MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Main_screen()));
                      Navigator.of(context).pop();
                    },
                    color: Colors.white38,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),


Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.white38,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      if (_userNameTextController.value.text != '') {
                        name = _userNameTextController.value.text;
                      }
                      final docUser = FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid);
                      docUser.update({
                        'username': name,
                        'gender': gender,
                        'birthday': birthday,
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Main_screen()));
                    },
                    color: Colors.white38,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
*/