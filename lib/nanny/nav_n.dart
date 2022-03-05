import 'package:flutter/material.dart';
import 'package:nannyish/nanny/Nanny.dart';
import 'package:nannyish/nanny/list_requests.dart';

class nav_n extends StatefulWidget {
  nav_n({Key? key}) : super(key: key);

  @override
  State<nav_n> createState() => _nav_nState();
}

class _nav_nState extends State<nav_n> {
  int currentIndex = 2;
  final List<Widget> screens = [
    ListRequests(),
    Center(child: Text('appointment')),
    Nanny(),
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
            label: 'Requests',
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
