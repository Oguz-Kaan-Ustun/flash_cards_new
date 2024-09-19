import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flash_cards_new/models/folder_model.dart';
import 'package:flash_cards_new/providers/disposable_provider.dart';
import 'package:flash_cards_new/utilities/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import '../widgets/folder_widget.dart';


class CardsDataBase extends DisposableProvider{
  // reference our box
  Box? _myBox;
  //List<FolderModel> _listOfDownloadedFolders = [];

  Box? get myBox => _myBox;
  //List<FolderModel> get listOfDownloadedFolders => _listOfDownloadedFolders;

  CardsDataBase(){
    getFolderModels();
    print('constructor: ${_myBox!.name}');
  }

  //run this method if creating new list
  void createInitialData(String listName) {
    _myBox!.put(listName, []);
    notifyListeners();
  }

  // load the data from database
  dynamic loadData(String listName) {
    return _myBox!.get(listName);
  }

  void getFolderModels(){
    String boxName = prefs!.getString(AppConstants.kBoxPreferenceKey)!;
    _myBox = Hive.box(boxName);
    print(boxName);
    print(_myBox!.values);
    print('box name: ${_myBox!.name}');

    notifyListeners();
  }

  //Delete Folder from downloaded folder tab
  void deleteFolder(String folderName){
    String uid = prefs!.getString(AppConstants.kBoxPreferenceKey)!;
    _myBox = Hive.box(uid);
    print('delete func: ${_myBox!.name}');
    _myBox!.delete(folderName);
    // _listOfDownloadedFolders.removeWhere((e) => e.name == folderName);
    // print(_listOfDownloadedFolders.length);
    notifyListeners();
  }

  // update the database
  void updateDataBase(String listName, List listContent) {
    _myBox = Hive.box(prefs!.getString(AppConstants.kBoxPreferenceKey)!);
    print('update func: ${_myBox!.name}');
    _myBox!.put(listName, listContent);
    notifyListeners();
  }

  // add flash card to database
  void addFlashCard(String listName, FlashModel flashModel){
    List newList = _myBox!.get(listName);
    newList.add(flashModel);
    _myBox!.put(listName, newList);

    notifyListeners();
  }

  void deleteFlashCard(String listName, int indexOfCard){
    List newList = _myBox!.get(listName);
    newList.removeAt(indexOfCard);
    _myBox!.put(listName, newList);

    notifyListeners();
  }

  void updateCardIsKnown(int listIndex, bool? isKnown, String listName) {
    List listFromBox = _myBox!.get(listName);
    FlashModel flashModelFromList = listFromBox[listIndex];
    flashModelFromList.isKnown = isKnown;
    listFromBox[listIndex] = flashModelFromList;
    updateDataBase(listName, listFromBox);

    notifyListeners();
  }

  void updateCardContents(int listIndex, String listName, FlashModel flashModel){
    List list = _myBox!.get(listName);
    list[listIndex] = flashModel;
    updateDataBase(listName, list);
  }

  //Other Stuff
  bool forceUpdateBool = true;
  void forceUpdate() {
    forceUpdateBool = !forceUpdateBool;

    notifyListeners();
  }

  List getListData(String listName) {
    return List.of(_myBox!.get(listName));
  }

  @override
  void disposeValues() {
    _myBox = null;
  }

  @override
  void changeBoxName(String boxName) {
    _myBox = Hive.box(boxName);
  }
}