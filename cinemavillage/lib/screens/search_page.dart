import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});
  @override
  State<Search_Screen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<Search_Screen> {


  void updateList(String value){
    //functia asta va filtra lista noastra
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search for a Movie",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                  ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 222, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "ex: The Dark Knight",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color.fromARGB(255, 155, 122, 120)
              )),
          ],
        ),
      ),
    );
  }
}
