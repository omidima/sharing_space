// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      createdAt: json['createdAt'] as String?,
      sender: json['sender'] as String?,
      type: json['type'] as String?,
      body: json['body'] as String?,
      workspace: json['workspace'] == null
          ? null
          : SpaceDto.fromJson(json['workspace'] as Map<String, dynamic>),
      files: json['files'] == null
          ? null
          : FileDto.fromJson(json['files'] as Map<String, dynamic>),
      objectId: json['objectId'] as String?,
    );

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'sender': instance.sender,
      'type': instance.type,
      'body': instance.body,
      'workspace': instance.workspace,
      'files': instance.files,
    };
