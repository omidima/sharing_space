// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceDto _$SpaceDtoFromJson(Map<String, dynamic> json) => SpaceDto(
      createdAt: json['createdAt'] as String?,
      group_name: json['group_name'] as String?,
      objectId: json['objectId'] as String?,
    );

Map<String, dynamic> _$SpaceDtoToJson(SpaceDto instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'group_name': instance.group_name,
    };
