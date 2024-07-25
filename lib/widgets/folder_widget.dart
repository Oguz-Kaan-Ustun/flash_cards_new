import 'package:flutter/material.dart';
import 'package:flash_cards_new/models/folder_model.dart';
import 'package:flash_cards_new/providers/card_provider.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards_new/screens/folder_main_screen.dart';

class FolderWidget extends StatelessWidget {
  FolderWidget({required this.folderModel});

  final FolderModel folderModel;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 14,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.lightBlue[50]),
                  iconColor: WidgetStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  Provider.of<CardProvider>(context, listen: false)
                      .giveListName(folderModel.name);
                  Navigator.pushNamed(
                    context,
                    FolderMainScreen.id,
                    arguments: ScreenArguments(folderName: folderModel.name)
                  );
                },
                child: Container(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_none),
                      SizedBox(width: 15),
                      Text(
                        folderModel.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}






// SizedBox(width: 1),
// ElevatedButton(
// style: ButtonStyle(
// backgroundColor:
// MaterialStateProperty.all(Colors.lightBlue[50]),
// iconColor: MaterialStateProperty.all(Colors.black),
// ),
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// TestMainScreen(folderName: folderModel.name)));
// },
// child: Container(
// height: 60,
// child: Icon(Icons.article_outlined),
// ),
// ),
// SizedBox(width: 1),
// ElevatedButton(
// style: ButtonStyle(
// backgroundColor:
// MaterialStateProperty.all(Colors.lightBlue[50]),
// iconColor: MaterialStateProperty.all(Colors.black),
// ),
// onPressed: () {
// showModalBottomSheet(
// isScrollControlled: true,
// showDragHandle: true,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.vertical(
// top: Radius.circular(20.0),
// ),
// ),
// backgroundColor: Colors.white,
// context: context,
// builder: (context) => SingleChildScrollView(
// child: Container(
// padding: EdgeInsets.only(
// bottom: MediaQuery.of(context).viewInsets.bottom),
// child: AddFlashCardScreen(listName: folderModel.name),
// ),
// ),
// );
// },
// child: Container(
// height: 60,
// child: Icon(Icons.more_horiz),
// ),
// ),
