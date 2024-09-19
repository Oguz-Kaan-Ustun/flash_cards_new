import 'package:flash_cards_new/services/firestore_database.dart';
import 'package:flash_cards_new/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards_new/widgets/rounded_button.dart';
import 'package:flash_cards_new/utilities/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../services/auth_service.dart';

enum UserRoles { student, teacher, moderator, admin }

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  late String email;
  late String password;
  late String nickName;

  final AuthService _authService = AuthService();
  String error = '';

  UserRoles? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  nickName = value;
                },
                decoration: AppConstants.kTextFieldDecoration
                    .copyWith(hintText: 'Nickname'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: AppConstants.kTextFieldDecoration
                    .copyWith(hintText: 'Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: AppConstants.kTextFieldDecoration
                    .copyWith(hintText: 'Password'),
              ),
              SizedBox(
                height: 8.0,
              ),
              PopupMenuButton<UserRoles>(
                initialValue: selectedItem,
                onSelected: (UserRoles role) {
                  setState(() {
                    selectedItem = role;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<UserRoles>>[
                  const PopupMenuItem<UserRoles>(
                    value: UserRoles.student,
                    child: Text('Student'),
                  ),
                  const PopupMenuItem<UserRoles>(
                    value: UserRoles.teacher,
                    child: Text('Teacher'),
                  ),
                  const PopupMenuItem<UserRoles>(
                    value: UserRoles.moderator,
                    child: Text('Moderator'),
                  ),
                  const PopupMenuItem(
                    value: UserRoles.admin,
                    child: Text('Admin'),
                  ),
                ],
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.blueAccent, width: 1),
                    color: Colors.white,
                  ),
                  child: Center(child: Text(selectedItem.toString()!='null' ? selectedItem.toString().split('.').last : 'Choose a role')),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  dynamic result =
                      await _authService.registerWithEmailAndPassword(
                          email, password, nickName, selectedItem!);
                  if (result == null) {
                    setState(() {
                      showSpinner = false;
                      error = 'Please supply a valid email';
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
