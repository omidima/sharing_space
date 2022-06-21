import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SpaceProvider {
  var provider = ParseObject('spaces');

  Future<ParseResponse> createNewSpace(String groupName) async {
    var data = provider..set('group_name', groupName);
    return await data.save();
  }

  Future<ParseResponse> getSpaceList() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('spaces'));
    return await queryTodo.query();
  }

  Future<ParseResponse> chcekValidSpace(String spaceId) async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('spaces'));
    queryTodo.whereEqualTo('objectId', spaceId);
    return await queryTodo.query();
  }
}
