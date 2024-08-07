import 'package:flutter/material.dart';
import 'package:flash_cards_new/screens/home_screen.dart';
import 'package:flash_cards_new/screens/profile_screen.dart';
import 'package:flash_cards_new/screens/create_screen.dart';

class BuildNavBar extends StatefulWidget {
  const BuildNavBar({super.key});

  @override
  State<BuildNavBar> createState() => _BuildNavBarState();
}

class _BuildNavBarState extends State<BuildNavBar> {

  int currentIndex = 0;

  void _onItemTapped(int index) {
    if (index > -1) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  final screens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            backgroundColor: Colors.white,
              context: context,
              builder: (context) => SingleChildScrollView(
                child:Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: CreateScreen(),
                ),
              ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        elevation: 10.0,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        elevation: 5,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => setState(() {
          _onItemTapped(index);
        }),
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}

