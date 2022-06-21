// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDto _$FileDtoFromJson(Map<String, dynamic> json) => FileDto(
      createdAt: json['createdAt'] as String?,
      file_address: json['file_address'] as String?,
      file_name: json['file_name'] as String?,
      file_size: json['file_size'] as String?,
      objectId: json['objectId'] as String?,
    );

Map<String, dynamic> _$FileDtoToJson(FileDto instance) => <String, dynamic>{
      'file_name': instance.file_name,
      'file_size': instance.file_size,
      'file_address': instance.file_address,
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
    };
