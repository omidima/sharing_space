import 'package:json_annotation/json_annotation.dart' as j;
part 'file_dto.g.dart';

@j.JsonSerializable()
class FileDto {
  final String? file_name;
  final String? file_size;
  final String? file_address;
  final String? objectId;
  final String? createdAt;

  FileDto(
      {this.createdAt,
      this.file_address,
      this.file_name,
      this.file_size,
      this.objectId});

  factory FileDto.fromJson(Map<String, dynamic> json) =>
      _$FileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FileDtoToJson(this);
}
