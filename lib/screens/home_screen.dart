import 'package:flash_cards_new/services/firestore_database.dart';
import 'package:flash_cards_new/widgets/folder_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: StreamBuilder(
            stream: _firestoreDatabase.getFolders(),
            builder: (context, snapshot) {
              List folders = snapshot.data?.docs ?? [];
              if (folders.isEmpty) {
                return const Center(
                  child: Text("Add a folder!"),
                );
              }
              return ListView(
                  children: folders
                      .map((e) => FolderWidget(
                          folderLocation: FolderLocation.shop,
                          folderName: e.data().name,
                          docId: e.id,
                          ownerId: e.data().ownerId,))
                      .toList());
            }),
      ),
    );
  }
}
