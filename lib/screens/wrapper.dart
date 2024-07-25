import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_cards_new/screens/authenticate/welcome_screen.dart';
import 'package:flash_cards_new/tabs/build_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return WelcomeScreen();
    } else {
      return BuildNavBar();
    }

  }
}