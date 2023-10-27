import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});
  @override
  State<Search_Screen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<Search_Screen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Top_bar(screenHeight, screenWidth),
    );
  }
}
