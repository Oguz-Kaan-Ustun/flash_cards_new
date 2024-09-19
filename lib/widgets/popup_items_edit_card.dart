import 'package:flash_cards_new/services/firestore_database.dart';
import 'package:flutter/material.dart';
import '../screens/bottom_and_pop_up/add_flash_card_screen.dart';

class PopupItemsEditCard extends StatelessWidget {
  PopupItemsEditCard({
    required this.listName,
    required this.indexOfCard,
    required this.docId,
    required this.existingCards,
    required this.ownerId,
  });
  final String listName;
  final int indexOfCard;
  final String docId;
  final List existingCards;
  final String ownerId;

  @override
  Widget build(BuildContext context) {

    FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete Card'),
          tileColor: Colors.lightBlue[100],
          onTap: () {
            Navigator.pop(context);
            _firestoreDatabase.deleteFlashCard(docId, existingCards, indexOfCard);
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
                    existingCards: existingCards,
                    docId: docId,
                    listName: listName,
                    isNewCard: false,
                    question: existingCards[indexOfCard]['Question'],
                    answer: existingCards[indexOfCard]['Answer'],
                    indexOfCard: indexOfCard,
                    ownerId: ownerId,
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
