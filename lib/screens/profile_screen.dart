import 'package:flash_cards_new/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.userModel});
  UserModel userModel;

  static const String id = 'profile_screen';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final String nickName = userModel.nickName;
    final String email = userModel.email;
    final String role = userModel.role;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Profile',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/logo.png'), // Replace with your image URL or asset
              backgroundColor: Colors.grey.shade200,
            ),
            SizedBox(height: 16),
            Text(
              'Nickname:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              nickName,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Email:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Role:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              role,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle edit profile action
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Edit Profile'),
                      content: Text('Edit profile functionality goes here.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
