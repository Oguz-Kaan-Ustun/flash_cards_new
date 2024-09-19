import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/models/user_model.dart';
import 'package:flash_cards_new/screens/authenticate/registration_screen.dart';
import 'package:flash_cards_new/screens/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards_new/screens/home_screen.dart';
import 'package:flash_cards_new/screens/profile_screen.dart';
import 'package:flash_cards_new/screens/bottom_and_pop_up/create_new_folder_bottom_sheet.dart';

class BuildNavBar extends StatefulWidget {
  BuildNavBar({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<BuildNavBar> createState() => _BuildNavBarState();
}

class _BuildNavBarState extends State<BuildNavBar> {
  int currentIndex = 0;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  void _onItemTapped(int index) {
    if (index > -1) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  late final screens = [
    HomeScreen(),
    LibraryScreen(userModel: userModel),
    ProfileScreen(userModel: userModel),
  ];

  @override
  Widget build(BuildContext context) {
    //CardsDataBase();//to reload the database
    return Scaffold(
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
              icon: Icon(Icons.library_books_outlined),
              selectedIcon: Icon(Icons.library_books),
              label: 'Library'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}


