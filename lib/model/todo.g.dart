// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      fields[1] as String,
      isCompleted: fields[2] as bool,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.task)
      ..writeByte(2)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FilterListAdapter extends TypeAdapter<FilterList> {
  @override
  final int typeId = 1;

  @override
  FilterList read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FilterList.tumu;
      case 1:
        return FilterList.tamamlanan;
      case 2:
        return FilterList.tamamlanmayan;
      default:
        return FilterList.tumu;
    }
  }

  @override
  void write(BinaryWriter writer, FilterList obj) {
    switch (obj) {
      case FilterList.tumu:
        writer.writeByte(0);
        break;
      case FilterList.tamamlanan:
        writer.writeByte(1);
        break;
      case FilterList.tamamlanmayan:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
