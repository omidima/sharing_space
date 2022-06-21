// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart' as j;
import 'package:share_space/data/dto/file_dto.dart';
import 'package:share_space/data/dto/space_dto.dart';
part 'workspace_item_dto.g.dart';

@j.JsonSerializable()
class MessageDto {
  final String? objectId;
  final String? createdAt;
  final String? sender;
  final String? type;
  final String? body;
  final SpaceDto? workspace;
  final FileDto? files;

  MessageDto(
      {this.createdAt,
      this.sender,
      this.type,
      this.body,
      this.workspace,
      this.files,
      this.objectId});

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
