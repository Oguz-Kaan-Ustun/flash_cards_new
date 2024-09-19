import 'package:flash_cards_new/data/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'disposable_provider.dart';

class AppProviders {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<CardsDataBase>(context, listen: false),
      //...other disposable providers
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }

  static void updateHiveBoxName(String boxName, BuildContext context) {
    Provider.of<CardsDataBase>(context, listen: false).changeBoxName(boxName);
  }
}