import 'package:flash_cards_new/data/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:provider/provider.dart';
import '../../data/database.dart';

class AddFlashCardScreen extends StatefulWidget {
  AddFlashCardScreen({
    required this.listName,
    this.question,
    this.answer,
    required this.isNewCard,
    this.indexOfCard,
    required this.existingCards,
    required this.docId,
    required this.ownerId,
  });

  String listName;
  String? question;
  String? answer;
  bool isNewCard;
  int? indexOfCard;
  List existingCards;
  String docId;
  String ownerId;

  @override
  State<AddFlashCardScreen> createState() => _AddFlashCardScreenState();
}

class _AddFlashCardScreenState extends State<AddFlashCardScreen> {
  FlashModel flashModel =
      FlashModel(back: 'Enter answer', front: 'Enter question', isKnown: false);

  FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flashModel.front = updateFlashModelFront();
    flashModel.back = updateFlashModelBack();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardsDataBase>(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: widget.question,
              textInputAction: TextInputAction.next,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Question',
              ),
              onChanged: (String value) {
                flashModel.front = value;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              initialValue: widget.answer,
              textInputAction: TextInputAction.next,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Answer',
              ),
              onChanged: (String value) {
                flashModel.back = value;
              },
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueGrey[50]),
                iconColor: WidgetStateProperty.all(Colors.black),
              ),
              onPressed: () {
                if (flashModel.front != 'Enter question' &&
                    flashModel.back != 'Enter answer') {
                  if (widget.isNewCard) {
                    widget.existingCards.add({
                      'Answer': flashModel.back,
                      'Question': flashModel.front
                    });
                    _firestoreDatabase.addFlashCard(
                        widget.existingCards, widget.listName, widget.docId, widget.ownerId);
                    Navigator.pop(context);
                  } else if (widget.indexOfCard != null) {
                    _firestoreDatabase.updateFlashCard(widget.docId,
                        widget.existingCards, widget.indexOfCard!, {
                      'Answer': flashModel.back,
                      'Question': flashModel.front
                    });
                    Navigator.pop(context);
                  }
                } else {
                  throw ('Please fill in the required fields');
                }
              },
              child: Container(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_outlined),
                    SizedBox(width: 15),
                    Text(
                      buttonTitle(),
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
            SizedBox(height: 25)
          ],
        ),
      ),
    );
  }

  String buttonTitle() {
    if (widget.isNewCard) {
      return 'Add Flash Card';
    } else {
      return 'Change Flash Card';
    }
  }

  String updateFlashModelFront() {
    if (!widget.isNewCard) {
      return widget.question as String;
    } else {
      return 'Enter question';
    }
  }

  String updateFlashModelBack() {
    if (!widget.isNewCard) {
      return widget.answer as String;
    } else {
      return 'Enter answer';
    }
  }
}
