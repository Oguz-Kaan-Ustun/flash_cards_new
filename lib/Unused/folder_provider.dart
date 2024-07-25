// import 'package:flutter/material.dart';
// import 'package:flash_cards/models/folder_model.dart';
//
//
// class FolderProvider extends ChangeNotifier{
//   List<String> _folderNames = [];
//   List<FolderModel> _folders = [];
//
//   void getList(List<String> list) {
//     _folderNames = list;
//     print(_folderNames);
//     _folders = folderNames.map((e) => FolderModel(name: e)).toList();
//     print(_folders);
//     print(_folders[0].name);
//
//     notifyListeners();
//
//   }
//
//   List<FolderModel> get folders => _folders;
//   List<String> get folderNames => _folderNames;
// }