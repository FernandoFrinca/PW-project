import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
