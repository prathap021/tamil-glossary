// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordsModelAdapter extends TypeAdapter<SaveWordsModel> {
  @override
  final int typeId = 1;

  @override
  SaveWordsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveWordsModel(
      body: fields[3] as String,
      id: fields[0] as String,
      title: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SaveWordsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
