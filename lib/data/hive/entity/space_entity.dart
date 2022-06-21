
import 'package:hive/hive.dart';
part 'space_entity.g.dart';

@HiveType(typeId: 1)
class SpaceEntity {
  @HiveField(0)
  String? objectId;

  @HiveField(1)
  String? createdAt;

  @HiveField(2)
  String? group_name;
}
