import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/data/firestore_database.dart';
import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flash_cards_new/screens/flash_card_learning_screen.dart';
import 'package:flash_cards_new/utilities/constants.dart';
import 'package:flash_cards_new/widgets/dynamic_card_widget.dart';
import 'package:flash_cards_new/widgets/folder_widget.dart';
import 'package:flash_cards_new/widgets/popup_items_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../providers/card_provider.dart';
import 'bottom_and_pop_up/add_flash_card_screen.dart';
import 'package:material_symbols_icons/symbols.dart';

final myIcon = Icon(Symbols.add_task);
final myRoundedIcon = Icon(Symbols.add_task_rounded);
final mySharpIcon = Icon(Symbols.add_task_sharp);

class ScreenArgumentsShop {
  ScreenArgumentsShop({required this.docId, required this.ownerId});
  String docId;
  String ownerId;
}

class FolderMainScreenShop extends StatefulWidget {
  static const String id = 'folder_main_screen';

  @override
  State<FolderMainScreenShop> createState() => _FolderMainScreenShopState();
}

class _FolderMainScreenShopState extends State<FolderMainScreenShop> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArgumentsShop;
    List<FlashModel> folderFlashCards;

    FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

    return StreamBuilder(
      stream: _firestoreDatabase.getCards(args.docId),
      builder: (context, AsyncSnapshot snapshot) {
        var firestoreData = snapshot.data?.data();
        if (firestoreData == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        String folderName = firestoreData.name;
        List cardsList = firestoreData.contents;
        String ownerId = firestoreData.ownerId;
        folderFlashCards = cardsList.map((e)=>
            FlashModel(back: e['Question'], front: e['Answer'], isKnown: false)
        ).toList();
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(
              '${folderName}',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.download),
                onPressed: (){
                  print('update button:');
                  print(prefs!.getString(AppConstants.kBoxPreferenceKey));
                  Provider.of<CardsDataBase>(context, listen: false).updateDataBase(folderName, folderFlashCards);
                },
              ),
            ],
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
                          .giveListName(folderName);
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
                              folderName: folderName,
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
                                listName: folderName, isNewCard: true, existingCards: cardsList, docId: args.docId, ownerId: args.ownerId),
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
                  !cardsList.isEmpty
                      ? Column(
                          children: cardsList
                              .map((e) => DynamicCardWidget(
                                    flashModel: FlashModel(back: e['Answer'], front: e['Question'], isKnown: false),
                                    listName: folderName,
                                    indexOfCard: cardsList.indexOf(e),
                                    docId: args.docId,
                                    existingCards: cardsList,
                                    folderLocation: FolderLocation.shop,
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
