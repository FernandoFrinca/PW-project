import 'package:cinemavillage/screens/admin_page.dart';
import 'package:cinemavillage/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final List<Widget> _widgetOptions = <Widget>[
    MovieSearch(),
    const Home_screen(),
    const Profile_screen(),
    const Admin_screen(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _isAdmin = 0;
  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          _isAdmin = snapshot.data()!["isAdmin"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
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
          if (_isAdmin == 1 && userType != 0)
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.admin_panel_settings,
              ),
              label: 'Admin',
            ),
        ],
      ),
    );
  }
}
