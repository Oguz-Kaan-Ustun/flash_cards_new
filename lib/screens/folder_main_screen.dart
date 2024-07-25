import 'package:flash_cards_new/screens/flash_card_learning_screen.dart';
import 'package:flash_cards_new/widgets/dynamic_card_widget.dart';
import 'package:flash_cards_new/widgets/popup_items_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flash_cards_new/data/database.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import 'add_flash_card_screen.dart';
import 'package:material_symbols_icons/symbols.dart';

final myIcon = Icon(Symbols.add_task);
final myRoundedIcon = Icon(Symbols.add_task_rounded);
final mySharpIcon = Icon(Symbols.add_task_sharp);

class ScreenArguments {
  ScreenArguments({required this.folderName});
  String folderName;
}

class FolderMainScreen extends StatefulWidget {
  static const String id = 'folder_main_screen';

  @override
  State<FolderMainScreen> createState() => _FolderMainScreenState();
}

class _FolderMainScreenState extends State<FolderMainScreen> {
  List cards = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    final provider = Provider.of<CardsDataBase>(context, listen: true);
    cards = provider.myBox.get(args.folderName).toList();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          '${args.folderName}',
        ),
      ),
      body: ListView(children: [
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
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddFlashCardScreen(
                            listName: args.folderName, isNewCard: true),
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 35),
                      SizedBox(width: 10),
                      Text(
                        'Add Flash Card',
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
              !cards.isEmpty
                  ? Column(
                      children: cards
                          .map((e) => DynamicCardWidget(
                                flashModel: e,
                                listName: args.folderName,
                                indexOfCard: cards.indexOf(e),
                                isDoubled: false,
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
