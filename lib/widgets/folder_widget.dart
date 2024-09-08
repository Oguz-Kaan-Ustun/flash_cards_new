import 'package:flash_cards_new/screens/folder_main_screen_downloaded.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards_new/screens/folder_main_screen_shop.dart';

enum FolderLocation{downloaded, shop, userFolders}

class FolderWidget extends StatelessWidget {
  FolderWidget({
    required this.folderName,
    this.docId,
    required this.folderLocation,
    this.folderContents,
    this.ownerId,
  });

  final String folderName;
  final String? docId;
  final FolderLocation folderLocation;
  List? folderContents;
  String? ownerId;

  @override
  Widget build(BuildContext context) {

    List<Widget> rowOfWidgets = [
      Icon(Icons.filter_none),
      SizedBox(width: 15),
      Text(
        folderName,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ];

    // if(folderLocation == FolderLocation.shop){
    //   folderContents = folderContents!.map((e)=>
    //       FlashModel(back: e['Question'], front: e['Answer'], isKnown: false)
    //   ).toList();
    //   rowOfWidgets.add(
    //     Spacer(),
    //   );
    //   rowOfWidgets.add(
    //     IconButton(
    //       icon: Icon(Icons.download),
    //       onPressed: (){
    //         _cardsDataBase.updateDataBase(folderName, folderContents!);
    //       },
    //     ),
    //   );
    // }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 14,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.all(Colors.lightBlue[50]),
                  iconColor: WidgetStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  if(folderLocation == FolderLocation.downloaded){
                    Navigator.pushNamed(
                        context,
                        FolderMainScreenDownloaded.id,
                        arguments: ScreenArgumentsDownloaded(folderName: folderName, folderContent: folderContents!)
                    );
                  } else if(folderLocation == FolderLocation.shop){
                    Navigator.pushNamed(
                        context,
                        FolderMainScreenShop.id,
                        arguments: ScreenArgumentsShop(docId: docId!, ownerId: ownerId!)
                    );
                  }
                },
                child: Container(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: rowOfWidgets,
                  ),
                ),
              ),
            ),
          ]
        ),
        SizedBox(height: 10),
      ],
    );
  }
}






// SizedBox(width: 1),
// ElevatedButton(
// style: ButtonStyle(
// backgroundColor:
// MaterialStateProperty.all(Colors.lightBlue[50]),
// iconColor: MaterialStateProperty.all(Colors.black),
// ),
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// TestMainScreen(folderName: folderModel.name)));
// },
// child: Container(
// height: 60,
// child: Icon(Icons.article_outlined),
// ),
// ),
// SizedBox(width: 1),
// ElevatedButton(
// style: ButtonStyle(
// backgroundColor:
// MaterialStateProperty.all(Colors.lightBlue[50]),
// iconColor: MaterialStateProperty.all(Colors.black),
// ),
// onPressed: () {
// showModalBottomSheet(
// isScrollControlled: true,
// showDragHandle: true,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.vertical(
// top: Radius.circular(20.0),
// ),
// ),
// backgroundColor: Colors.white,
// context: context,
// builder: (context) => SingleChildScrollView(
// child: Container(
// padding: EdgeInsets.only(
// bottom: MediaQuery.of(context).viewInsets.bottom),
// child: AddFlashCardScreen(listName: folderModel.name),
// ),
// ),
// );
// },
// child: Container(
// height: 60,
// child: Icon(Icons.more_horiz),
// ),
// ),
