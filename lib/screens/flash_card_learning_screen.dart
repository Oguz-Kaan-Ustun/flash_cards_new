import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/widgets/flash_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards_new/providers/card_provider.dart';

class FlashCardLearningScreen extends StatefulWidget {
  static const String id = 'flash_card_screen';

  @override
  State<FlashCardLearningScreen> createState() =>
      _FlashCardLearningScreenState();
}

class _FlashCardLearningScreenState extends State<FlashCardLearningScreen> {
  late bool isFront;

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final cards = provider.cards;
    final listName = provider.listName;

    CardsDataBase dataBase = CardsDataBase();

    return dataBase.loadData(listName).isNotEmpty
        ? cards.isEmpty
            ? Center(
                child: ElevatedButton(
                  child: Text('Restart'),
                  onPressed: () {
                    final provider =
                        Provider.of<CardProvider>(context, listen: false);
                    provider.resetUsers();
                  },
                ),
              )
            : Stack(
                children: cards
                    .map((e) => FlashCardWidget(
                          flashModel: e,
                          isTop: cards.last == e,
                        ))
                    .toList())
        : Center(
            child: Container(
              child: Text('Add flash cards first'),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              final provider =
              Provider.of<CardProvider>(context, listen: false);
              provider.resetUsers();
            },
          ),
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Learning Screen',
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: double.infinity,
              ),
              buildCards(),
            ],
          ),
        ),
      ),
      onWillPop: () async{
        return false;
      },
    );
  }
}
