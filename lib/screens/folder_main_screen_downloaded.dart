import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flash_cards_new/screens/flash_card_learning_screen.dart';
import 'package:flash_cards_new/widgets/dynamic_card_widget.dart';
import 'package:flash_cards_new/widgets/folder_widget.dart';
import 'package:flash_cards_new/widgets/popup_items_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import 'package:material_symbols_icons/symbols.dart';

final myIcon = Icon(Symbols.add_task);
final myRoundedIcon = Icon(Symbols.add_task_rounded);
final mySharpIcon = Icon(Symbols.add_task_sharp);

class ScreenArgumentsDownloaded {
  ScreenArgumentsDownloaded({required this.folderName, required this.folderContent});
  String folderName;
  List folderContent;
}

class FolderMainScreenDownloaded extends StatefulWidget {
  static const String id = 'folder_main_screen_downloaded';

  @override
  State<FolderMainScreenDownloaded> createState() => _FolderMainScreenDownloadedState();
}

class _FolderMainScreenDownloadedState extends State<FolderMainScreenDownloaded> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArgumentsDownloaded;

    return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(
              '${args.folderName}',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  Provider.of<CardsDataBase>(context, listen: false).deleteFolder(args.folderName);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: ListView(
              children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.lightBlue[50]),
                      iconColor: WidgetStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Provider.of<CardProvider>(context, listen: false)
                          .giveListName(args.folderName);
                      Navigator.pushNamed(
                        context,
                        FlashCardLearningScreen.id,
                      ).then((_) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Symbols.neurology, size: 35),
                          SizedBox(width: 10),
                          Text(
                            'Learn',
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
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.lightBlue[50]),
                      iconColor: WidgetStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        showDragHandle: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                        ),
                        backgroundColor: Colors.lightBlue[100],
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: PopupItemsQuizScreen(
                              folderName: args.folderName,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Symbols.quiz, size: 35),
                          SizedBox(width: 10),
                          Text(
                            'Quiz',
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
                  MyDivider(),
                  Container(
                    child: Text(
                      'Flash Cards',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 10),
                  !args.folderContent.isEmpty
                      ? Column(
                          children: args.folderContent
                              .map((e) => DynamicCardWidget(
                                    flashModel: FlashModel(back: e.back, front: e.front, isKnown: e.isKnown),
                                    existingCards: args.folderContent
                            ,
                                    folderLocation: FolderLocation.downloaded,
                                  ))
                              .toList(),
                        )
                      : Center(
                          child: Container(
                            child: Text('Add flash cards first'),
                          ),
                        ),
                ],
              ),
            ),
          ]),
        );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      color: Colors.black,
      height: 40,
      endIndent: 30,
      indent: 30,
    );
  }
}
