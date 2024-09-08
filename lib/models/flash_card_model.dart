
import 'package:hive/hive.dart';

part 'flash_card_model.g.dart';

@HiveType(typeId: 1)
class FlashModel extends HiveObject{
  @HiveField(0)
  String front;
  @HiveField(1)
  String back;
  @HiveField(2)
  bool? isKnown;

  FlashModel({
    required this.back,
    required this.front,
    required this.isKnown,
  });

  static List<FlashModel> flashModelList() {
    return[
      FlashModel(back: '1', front: '2', isKnown: false),
      FlashModel(back: '3', front: '4', isKnown: false),
      FlashModel(back: '5', front: '6', isKnown: false),
    ];
  }
}