import 'package:flash_cards_new/data/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NewFolderScreen extends StatefulWidget {

  NewFolderScreen({required this.parentContext});

  final BuildContext parentContext;

  @override
  State<NewFolderScreen> createState() => _NewFolderScreenState();
}

class _NewFolderScreenState extends State<NewFolderScreen> {

  // final _myBox = Hive.box('mybox');
  CardsDataBase dataBase = CardsDataBase();

  // final List<String> listOfFolderNames = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Folder Name',
              ),
              onSubmitted: (String value) {
                  if (dataBase.loadData(value) == null) {
                    Provider.of<CardsDataBase>(context, listen: false).createInitialData(value);
                  } else {
                    throw('List Already Exists');
                  }
                  Navigator.pop(widget.parentContext);
                  Navigator.pop(context);
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
