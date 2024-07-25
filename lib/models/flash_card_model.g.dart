// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashModelAdapter extends TypeAdapter<FlashModel> {
  @override
  final int typeId = 1;

  @override
  FlashModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashModel(
      back: fields[1] as String,
      front: fields[0] as String,
      isKnown: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FlashModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.front)
      ..writeByte(1)
      ..write(obj.back)
      ..writeByte(2)
      ..write(obj.isKnown);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
