import 'package:hive/hive.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:share_space/core/const/pref_key.dart';
import 'package:share_space/data/dto/workspace_item_dto.dart';
import 'package:share_space/data/enums/messsage_type.dart';

class MessageProvider {
  var provider = ParseObject('space_items');

  Future<ParseResponse> createMessage(
      MessageDto workspaceItemDto, ParseObject? files) async {
    final QueryBuilder<ParseObject> publisherQueryA =
        QueryBuilder<ParseObject>(ParseObject('spaces'))
          ..whereEqualTo('objectId', Hive.box(MAIN_BOX).get(HiveData.spaceId));
    final ParseResponse publisherResponse = await publisherQueryA.query();
    final publisherA = publisherResponse.results?.first as ParseObject;

    var data = provider
      ..set('body', workspaceItemDto.body)
      ..set('type', workspaceItemDto.type)
      ..set('sender', workspaceItemDto.sender);
    files != null ? data.addRelation('files', [files]) : null;

    data.addRelation('workspace', [publisherA]);

    return await data.save();
  }

  Future<ParseResponse> getSpaceMessage(
      String spaceId, MessageType messageType) async {
    final QueryBuilder<ParseObject> publisherQueryA =
        QueryBuilder<ParseObject>(ParseObject('spaces'))
          ..whereEqualTo('objectId', spaceId);
    final ParseResponse publisherResponse = await publisherQueryA.query();
    final publisherA = publisherResponse.results?.first as ParseObject;

    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(provider)
          ..whereEqualTo('workspace', publisherA)
          ..whereEqualTo('type', messageType.value)
          ..orderByDescending('createdAt');
    return await parseQuery.query();
  }
}
