import 'dart:convert';

import 'package:cinemavillage/models/movie_model_OMDb.dart';
import 'package:cinemavillage/screens/details_screen_movies_OMDb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Image logoWidget(String imageName, dynamic widthIn, dynamic heightIn) {
  int VariableWidthIn = widthIn;
  int VariableHeighIn = heightIn;
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    //300
    width: VariableWidthIn.toDouble(),
    //240
    height: VariableHeighIn.toDouble(),
    color: Colors.white,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

TextField updateText(
    String text, IconData icon, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
  );
}

Container printText(
    String text, IconData icon, double containerWidth, double containerHeight) {
  return Container(
    width: containerWidth,
    height: containerHeight,
    decoration: BoxDecoration(
      color: Colors.white38,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Icon(icon, color: Colors.white),
        const SizedBox(
          width: 5,
        ),
        Text(
          text!,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Container singInSingUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Color.fromARGB(221, 52, 52, 52),
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Container Top_bar_orange(dynamic screenHeight, dynamic screenWidth) {
  var screenH = screenHeight;
  var screenW = screenWidth;
  return Container(
    child: Column(children: [
      Container(
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0.0, bottom: 0),
            child: logoWidget("assets/images/Cinema_village_2.png", 63, 80)),
        alignment: Alignment.bottomLeft,
        height: screenH.toDouble() / 8.3,
        width: screenW.toDouble(),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0),
          ),
          color: Color.fromARGB(255, 241, 81, 37),
        ),
      )
    ]),
  );
}

Container Top_bar_black(dynamic screenHeight, dynamic screenWidth) {
  var screenH = screenHeight;
  var screenW = screenWidth;
  return Container(
    child: Column(children: [
      Container(
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 55.0, bottom: 0),
            child: logoWidget("assets/images/Cinema_village_2.png", 63, 80)),
        alignment: Alignment.bottomLeft,
        height: screenH.toDouble() / 8.3,
        width: screenW.toDouble(),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(0),
            ),
            color: Color.fromARGB(255, 25, 25, 25)),
      )
    ]),
  );
}

// ignore: unused_element
class favoriteButton extends StatefulWidget {
  final String name;
  const favoriteButton({Key? key, required this.name}) : super(key: key);

  @override
  State<favoriteButton> createState() => _favoriteButtonState();
}

// ignore: camel_case_types
class _favoriteButtonState extends State<favoriteButton> {
  bool _isFavorite = false;
  List? favorites = null;
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
        List<String> titles = [];
        titles = favorites!.map((element) => element.toString()).toList();
        for (String title in titles) {
          if (title == widget.name) {
            _isFavorite = true;
            break;
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  void triggerFavorite() {
    setState(() {
      if (_isFavorite) {
        _isFavorite = false;
        final docUser = FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid);
        docUser.update({
          'favorites': FieldValue.arrayRemove([widget.name]),
        });
      } else {
        _isFavorite = true;
        final docUser = FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid);
        docUser.update({
          'favorites': FieldValue.arrayUnion([widget.name]),
        });
      }
    });
  }

  @override
  IconButton build(BuildContext context) {
    return IconButton(
      onPressed: () {
        triggerFavorite();
      },
      style: IconButton.styleFrom(
        backgroundColor: Colors.white10,
        iconSize: 25,
      ),
      icon: (_isFavorite
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_border,
              color: Colors.white,
            )),
    );
  }
}

class ListElement extends StatelessWidget {
  final child;
  const ListElement({required String this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final apiKey = "67ae677b";
        var firstImdbID = "tt2015381";

        final movieName = child;
        final apiUrl1 =
            Uri.parse("http://www.omdbapi.com/?s=$movieName&apikey=$apiKey");

        final response1 = await http.get(apiUrl1);

        if (response1.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response1.body);
          if (data['Response'] == 'True') {
            // Check if the response is successful
            firstImdbID = data['Search'][0]['imdbID'];
          }
        }

        final apiUrl2 =
            Uri.parse("http://www.omdbapi.com/?i=$firstImdbID&apikey=$apiKey");

        final response2 = await http.get(apiUrl2);

        if (response2.statusCode == 200) {
          final data = json.decode(response2.body);
          final movieModel = MovieModel.fromJson(data);

          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen_OMDb(movieModel),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Container(
          height: 80,
          color: Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                child,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ignore: prefer_const_constructors
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        // ignore: prefer_const_constructors
                        child: favoriteButton(name: child),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListElementAdmin extends StatelessWidget {
  final email;
  final username;
  final document;
  final type;
  final curentUser;
  const ListElementAdmin(
      {this.email, this.username, this.document, this.type, this.curentUser});

  @override
  Widget build(BuildContext context) {
    bool change = false;
    bool admin = false;
    if (curentUser == 1) admin = true;
    if (type == 1)
      change = false;
    else
      change = true;
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              email,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              username,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      // ignore: prefer_const_constructors
                      child: IconButton(
                        icon: (change
                            ? const Icon(
                                Icons.add_moderator_outlined,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.admin_panel_settings,
                                color: Colors.green,
                              )),
                        onPressed: () {
                          int set = 0;
                          if (change == true)
                            set = 1;
                          else
                            set = 0;
                          final docUser = FirebaseFirestore.instance
                              .collection('users')
                              .doc(document);
                          docUser.update({
                            'isAdmin': set,
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // ignore: prefer_const_constructors
              Container(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      // ignore: prefer_const_constructors
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          if (admin) {
                            final docUser = FirebaseFirestore.instance
                                .collection('users')
                                .doc(document);
                            docUser.delete();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentsList extends StatelessWidget {
  final List<String> comments;
  final Function(int index) onDelete;
  final int isAdmin;
  final int userType;
  const CommentsList({
    Key? key,
    required this.comments,
    required this.onDelete,
    required this.isAdmin,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments.map((comment) {
          int index = comments.indexOf(comment);
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 26, 26),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 26, 26, 26).withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  comment,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: (isAdmin == 1 && userType != 0)
                    ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => onDelete(index),
                          ),
                          Text(""),
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
