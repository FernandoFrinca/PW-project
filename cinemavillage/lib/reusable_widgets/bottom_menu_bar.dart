import 'package:flutter/material.dart';
import 'package:cinemavillage/screens/home_page.dart';
import 'package:cinemavillage/screens/search_page_2.dart';

class _NavigationBar extends StatefulWidget {
  const _NavigationBar({super.key});

  @override
  State<_NavigationBar> createState() => NavigationBarState();
}

class NavigationBarState extends State<_NavigationBar> {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    const Home_screen(),
    MovieSearch(),
    const Text('Profile'),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        backgroundColor: Color.fromARGB(255, 25, 25, 25),
        unselectedItemColor: Color.fromARGB(255, 206, 208, 206),
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
