import 'package:flutter/material.dart';
import 'package:nannyish/parent/list.dart';
import 'package:nannyish/parent/parent.dart';

class nav_p extends StatefulWidget {
  nav_p({Key? key}) : super(key: key);

  @override
  State<nav_p> createState() => _nav_pState();
}

class _nav_pState extends State<nav_p> {
  int currentIndex = 2;
  final List<Widget> screens = [
    list(),
    Center(child: Text('appointment',

    )),
    parent(),
  ];

  void _onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTappedBar,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.copy_outlined),
            label: 'Appoinment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(0xFFB3D0D7),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
