import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flash_cards_new/utilities/constants.dart';

class CardsDataBase extends ChangeNotifier {
  // reference our box
  Box _myBox = Hive.box(AppConstants.flashCardBoxName);
  Box get myBox => _myBox;

  //run this method if creating new list
  void createInitialData(String listName) {
    _myBox.put(listName, []);
    notifyListeners();
  }

  // load the data from database
  dynamic loadData(String listName) {
    return _myBox.get(listName);
  }

  // update the database
  void updateDataBase(String listName, List listContent) {
    _myBox.put(listName, listContent);

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

  bool forceUpdateBool = true;
  void forceUpdate() {
    forceUpdateBool = !forceUpdateBool;

    notifyListeners();
  }

  List getListData(String listName) {
    return List.of(_myBox.get(listName));
  }
}