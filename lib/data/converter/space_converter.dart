import 'package:share_space/data/hive/entity/space_entity.dart';

import '../dto/space_dto.dart';

class SpaceConverter {
  static SpaceEntity spaceDtoToSpaceEntity(SpaceDto spaceDto) => SpaceEntity()
    ..createdAt = spaceDto.createdAt
    ..group_name = spaceDto.group_name
    ..objectId = spaceDto.objectId;

  static SpaceDto spaceEntityToSpaceDto(SpaceEntity spaceEntity) => SpaceDto(
    createdAt: spaceEntity.createdAt,
    group_name: spaceEntity.group_name,
    objectId: spaceEntity.group_name
  );
}
