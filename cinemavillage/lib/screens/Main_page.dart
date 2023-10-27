import 'package:cinemavillage/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:cinemavillage/screens/search_page.dart';
import 'package:cinemavillage/screens/home_page.dart';

class Main_screen extends StatefulWidget {
  const Main_screen({super.key});
  State<Main_screen> createState() => MainPage();
}

class MainPage extends State<Main_screen> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    Search_Screen(),
    Home_screen(),
    Profile_screen(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _widgetOptions
              .elementAt(_selectedIndex)), //schimba textul de pe ecran
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        backgroundColor: Color.fromARGB(255, 25, 25, 25),
        unselectedItemColor: Color.fromARGB(255, 227, 232, 227),
        selectedItemColor: Color.fromARGB(255, 241, 100, 37),
        iconSize: 30,
        selectedFontSize: 15,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
