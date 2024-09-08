import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/models/user_model.dart';
import 'package:flash_cards_new/widgets/folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_and_pop_up/create_new_folder_bottom_sheet.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    CardsDataBase cardsDataBase = CardsDataBase();
    final provider = Provider.of<CardsDataBase>(context);
    print(cardsDataBase.myBox.name);

    List<StatelessWidget> listForDownloadedColumn = [
      const Text('Downloaded Folders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      const MyDivider(),
    ];
    listForDownloadedColumn.addAll(provider.listOfDownloadedFolders);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
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
                child: CreateNewFolderScreen(ownerId: widget.userModel.userId),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        elevation: 10.0,
      ),
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listForDownloadedColumn,
              ),
              const Text('Your Folders',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const MyDivider(),
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
    return const Divider(
      thickness: 1,
      color: Colors.black,
      height: 40,
      endIndent: 30,
      indent: 30,
    );
  }
}
