import 'package:cinemavillage/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:cinemavillage/screens/search_page_2.dart';
import 'package:cinemavillage/screens/home_page.dart';

class Main_screen extends StatefulWidget {
  const Main_screen({super.key});
  State<Main_screen> createState() => MainPage();
}

int? userType;
userSet(int value) {
  userType = value;
}

int? getUserType() {
  return userType;
}

class MainPage extends State<Main_screen> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    MovieSearch(),
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
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          if (userType == 1)
            const BottomNavigationBarItem(
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
