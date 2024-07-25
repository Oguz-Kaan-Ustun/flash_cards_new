import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/widgets/dynamic_card_widget_with_no_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/flash_card_model.dart';


class QuizScreen extends StatefulWidget {
  QuizScreen({required this.folderName});
  String folderName;
  static const String id = 'multiple_choice_quiz_screen';

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  CardsDataBase dataBase = CardsDataBase();

  late List originalCards;
  late List questionCards;
  late List answerCards;
  late List newCards;
  double progressValue = 0.0;
  int finishedQuestions = 0;
  late List customOrder;


  @override
  void initState() {
    super.initState();
    originalCards = dataBase.getListData(widget.folderName);
    questionCards = List.from(originalCards);
    questionCards.shuffle();
    answerCards = List.from(originalCards);
    answerCards.shuffle();
    customOrder = originalCards.map((e) => e.front).toList();
    newCards = [];
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<CardsDataBase>(context, listen: false);

    void nextOfCards(List listName) {
      if (listName.isEmpty) return;
      FlashModel lastCard = listName.removeLast();
      listName.insert(0, lastCard);
      setState(() {

      });
    }

    void updateProgress(double newValue) {
      setState(() {
        progressValue = newValue;
      });
    }

    void matchCards() {
      FlashModel questionFlashModel = questionCards.removeLast();
      FlashModel answerFlashModel = answerCards.removeLast();
      questionFlashModel.back == answerFlashModel.back
          ? questionFlashModel.isKnown = true
          : questionFlashModel.isKnown = false;
      newCards.add(questionFlashModel);
      finishedQuestions++;
      updateProgress(finishedQuestions / originalCards.length);
    }

    void sortList() {
      newCards.sort((a, b) =>
          customOrder.indexOf(a.front).compareTo(customOrder.indexOf(b.front)));
    }

    void uploadNewList() {
      if (progressValue == 1) {
        sortList();
        provider.updateDataBase(widget.folderName, newCards.toList());
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      } else {
        return;
      }
    }

    Future<void> _dialogBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (dialogBuilderContext) {
            return AlertDialog(
              title: Text('Are you sure you want to leave?'),
              content: Text('You haven\'t finished your quiz yet'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogBuilderContext);
                    Navigator.pop(context);
                    provider.forceUpdate();
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogBuilderContext);
                  },
                  child: Text('No'),
                ),
              ],
            );
          });
    }

    Widget buildCards({required bool isFront, required List listName}) {
      return originalCards.isNotEmpty
          ? answerCards.isEmpty
              ? Container()
              : Stack(
                  clipBehavior: Clip.none,
                  children: listName
                      .map((e) => AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            bottom: e == listName[listName.length - 1] &&
                                    listName.length != 1
                                ? -15
                                : null,
                            right: e == listName[listName.length - 1] &&
                                    listName.length != 1
                                ? -15
                                : null,
                            child: DynamicCardWidgetWithNoMenu(
                                height: 150,
                                width: 300,
                                text: Text(isFront ? e.front : e.back,
                                    style: GoogleFonts.indieFlower(
                                      textStyle: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ))),
                          ))
                      .toList())
          : Center(
              child: Text(
                'Add flash cards first',
                style: TextStyle(color: Colors.white),
              ),
            );
    }

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(widget.folderName, style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _dialogBuilder(context),
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LinearProgressIndicator(
                  value: progressValue,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  minHeight: 5,
                ),
                Text(
                  '$finishedQuestions/${originalCards.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Scaffold(
                      backgroundColor: Colors.grey[900],
                      body: Center(
                        child:
                            buildCards(isFront: true, listName: questionCards),
                      ),
                      floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.autorenew),
                        backgroundColor: Colors.red,
                        onPressed: () {
                          setState(() {
                            nextOfCards(questionCards);
                          });
                        },
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Scaffold(
                      backgroundColor: Colors.grey[900],
                      body: Center(
                        child:
                            buildCards(isFront: false, listName: answerCards),
                      ),
                      floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.autorenew),
                        backgroundColor: Colors.red,
                        onPressed: () {
                          setState(() {
                            nextOfCards(answerCards);
                          });
                        },
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          matchCards();
                          uploadNewList();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.green),
                      ),
                      child: Text(
                        'True',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
