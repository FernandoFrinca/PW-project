import 'package:cinemavillage/screens/Main_page.dart';
import 'package:cinemavillage/screens/profile_page.dart';
import 'package:flutter/material.dart';

class favorites_screen extends StatefulWidget {
  const favorites_screen({super.key});

  @override
  State<favorites_screen> createState() => _favorites_screen();
}

class _favorites_screen extends State<favorites_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 25, 25),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
