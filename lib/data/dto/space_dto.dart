// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart' as j;
part 'space_dto.g.dart';

@j.JsonSerializable()
class SpaceDto {
  final String? objectId;
  final String? createdAt;
  final String? group_name;

  SpaceDto({required this.createdAt, required this.group_name,
      required this.objectId});

  factory SpaceDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceDtoToJson(this);
}
