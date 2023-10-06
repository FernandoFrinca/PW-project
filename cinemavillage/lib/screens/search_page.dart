import 'package:flutter/material.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});
  @override
  State<Search_Screen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<Search_Screen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Search')),
    );
  }
}
