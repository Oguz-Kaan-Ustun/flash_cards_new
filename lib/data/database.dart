import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flash_cards_new/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import '../widgets/folder_widget.dart';


class CardsDataBase extends ChangeNotifier{
  // reference our box
  late Box _myBox;
  List<FolderWidget> _listOfDownloadedFolders = [];
  Box get myBox => _myBox;
  List<FolderWidget> get listOfDownloadedFolders => _listOfDownloadedFolders;

  CardsDataBase(){
    reloadDatabase();
  }

  void reloadDatabase(){
    getFolderWidgets();
  }

  //run this method if creating new list
  void createInitialData(String listName) {
    _myBox.put(listName, []);
    notifyListeners();
  }

  // load the data from database
  dynamic loadData(String listName) {
    return _myBox.get(listName);
  }

  List<FolderWidget> getFolderWidgets(){
    _myBox = Hive.box(prefs!.getString(AppConstants.kBoxPreferenceKey)!);
    List listOfKeys = _myBox.keys.toList();
    _listOfDownloadedFolders = listOfKeys.map((e)=>
        FolderWidget(
            folderName: e,
            folderLocation: FolderLocation.downloaded,
            folderContents: _myBox.get(e))).toList();
    notifyListeners();
    return _listOfDownloadedFolders;
  }

  //Delete Folder from downloaded folder tab
  void deleteFolder(String folderName){
    _myBox = Hive.box(prefs!.getString(AppConstants.kBoxPreferenceKey)!);
    print('delete func: ${_myBox.name}');
    _myBox.delete(folderName);
    _listOfDownloadedFolders.removeWhere((e) => e.folderName == folderName);
    print(_listOfDownloadedFolders.length);
    notifyListeners();
  }

  // update the database
  void updateDataBase(String listName, List listContent) {
    _myBox = Hive.box(prefs!.getString(AppConstants.kBoxPreferenceKey)!);
    print('update func: ${_myBox.name}');
    _myBox.put(listName, listContent);
    getFolderWidgets();
    notifyListeners();
  }

  // add flash card to database
  void addFlashCard(String listName, FlashModel flashModel){
    List newList = _myBox.get(listName);
    newList.add(flashModel);
    _myBox.put(listName, newList);

    notifyListeners();
  }

  void deleteFlashCard(String listName, int indexOfCard){
    List newList = _myBox.get(listName);
    newList.removeAt(indexOfCard);
    _myBox.put(listName, newList);

    notifyListeners();
  }

  void updateCardIsKnown(int listIndex, bool? isKnown, String listName) {
    List listFromBox = _myBox.get(listName);
    FlashModel flashModelFromList = listFromBox[listIndex];
    flashModelFromList.isKnown = isKnown;
    listFromBox[listIndex] = flashModelFromList;
    updateDataBase(listName, listFromBox);

    notifyListeners();
  }

  void updateCardContents(int listIndex, String listName, FlashModel flashModel){
    List list = _myBox.get(listName);
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
    return List.of(_myBox.get(listName));
  }
}