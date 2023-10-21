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
/*
void _showImageDialog(){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const Text("Choose an option:"),
      content: Column(
        mainAxisAlignment: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              _getFromCamera();
            },
            child: const Row(
              children: [
                Padding(padding: EdgeInsets.all(4),child: Icon(Icons.camera,color: Colors.black,),),
                Text("Camera", style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _getFromGallery();
            },
            child: const Row(
              children: [
                Padding(padding: EdgeInsets.all(4),child: Icon(Icons.image,color: Colors.black,),),
                Text("Gallery", style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
        ],
      ),
    )
  }
  )
}
*/