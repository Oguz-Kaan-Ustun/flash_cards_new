import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/database.dart';
import '../screens/add_flash_card_screen.dart';

class PopupItemsEditCard extends StatelessWidget {
  PopupItemsEditCard({required this.listName, required this.indexOfCard});
  final String listName;
  final int indexOfCard;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardsDataBase>(context);
    FlashModel flashModel = provider.loadData(listName)[indexOfCard];

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete Card'),
          tileColor: Colors.lightBlue[100],
          onTap: () {
            Navigator.pop(context);
            provider.deleteFlashCard(listName, indexOfCard);
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Edit Card'),
          tileColor: Colors.lightBlue[200],
          onTap: () {
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
                    listName: listName,
                    isNewCard: false,
                    question: flashModel.front,
                    answer: flashModel.back,
                    indexOfCard: indexOfCard,
                  ),
                ),
              ),
            ).then((_) => Navigator.pop(context));
          },
        ),
      ],
    );
  }
}
