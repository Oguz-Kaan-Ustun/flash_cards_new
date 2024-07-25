import 'package:flutter/material.dart';

class OpenEndedQuizScreen extends StatefulWidget {
  static const String id = 'open_ended_quiz_screen';

  @override
  State<OpenEndedQuizScreen> createState() => _OpenEndedQuizScreenState();
}

class _OpenEndedQuizScreenState extends State<OpenEndedQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
