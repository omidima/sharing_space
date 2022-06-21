import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:share_space/core/api_wrapper.dart';
import 'package:share_space/data/dto/workspace_item_dto.dart';
import 'package:share_space/data/enums/messsage_type.dart';
import 'package:share_space/data/provider/message_provider.dart';

class MessageRepository {
  MessageProvider provider = MessageProvider();

  MessageRepository._internal();
  static final MessageRepository _instance = MessageRepository._internal();
  static MessageRepository get getInstance => _instance;

  Future<ApiWrapper<List<MessageDto>>> createMessage(
      MessageDto workspaceItemDto, ParseObject? file) async {
    var result = await provider.createMessage(workspaceItemDto, file);

    if (result.success) {
      return ApiWrapper.success(data: [MessageDto.fromJson(json.decode(result.result.toString()))]);
    } else {
      return ApiWrapper.failure(error: result.error.toString());
    }
  }

  Future<ApiWrapper<List<MessageDto>>> getSpaceMessage(
      String workspaceId, MessageType messageType) async {
    var apiResponse = await provider.getSpaceMessage(workspaceId, messageType);

    if (apiResponse.success && apiResponse.results != null) {
      print(apiResponse.result);
      List<MessageDto> items = [];
      apiResponse.results!.forEach((element) {
        items.add(MessageDto.fromJson(json.decode(element.toString())));
      });

      return ApiWrapper.success(data: items);
    } else {
      return ApiWrapper.failure(error: apiResponse.error.toString());
    }
  }
}
