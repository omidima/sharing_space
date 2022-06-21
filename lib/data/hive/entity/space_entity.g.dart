// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaceEntityAdapter extends TypeAdapter<SpaceEntity> {
  @override
  final int typeId = 1;

  @override
  SpaceEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpaceEntity()
      ..objectId = fields[0] as String?
      ..createdAt = fields[1] as String?
      ..group_name = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, SpaceEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.objectId)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.group_name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaceEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
