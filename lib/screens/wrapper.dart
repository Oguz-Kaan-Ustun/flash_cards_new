import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_cards_new/services/firestore_database.dart';
import 'package:flash_cards_new/models/user_model.dart';
import 'package:flash_cards_new/screens/authenticate/welcome_screen.dart';
import 'package:flash_cards_new/tabs/build_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    Future<UserModel> futureData() async {
      return await _firestoreDatabase.getUser(user!.uid);
    }

    // return either the Home or Authenticate widget
    if (user == null) {
      return WelcomeScreen();
    } else {
      return FutureBuilder<UserModel>(
          future: futureData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return BuildNavBar(userModel: snapshot.data as UserModel);
            }
          });
    }
  }
}
