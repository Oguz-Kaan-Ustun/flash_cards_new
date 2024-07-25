import 'package:flash_cards_new/screens/multiple_choice_quiz_screen.dart';
import 'package:flash_cards_new/screens/open_ended_quiz_screen.dart';
import 'package:flutter/material.dart';

class PopupItemsQuizScreen extends StatelessWidget {
  PopupItemsQuizScreen({required this.folderName});
  String folderName;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.rule),
          title: Text('Multiple Choice'),
          tileColor: Colors.lightBlue[100],
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => QuizScreen(folderName: folderName),
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.draw),
          title: Text('Open Ended'),
          tileColor: Colors.lightBlue[200],
          onTap: () {
            Navigator.popAndPushNamed(context, OpenEndedQuizScreen.id);
          },
        ),
      ],
    );
  }
}
