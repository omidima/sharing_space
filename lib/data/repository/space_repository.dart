import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:share_space/core/api_wrapper.dart';
import 'package:share_space/data/dto/workspace_item_dto.dart';
import 'package:share_space/data/provider/space_provider.dart';

import '../dto/space_dto.dart';

class SpaceRepository {
  SpaceProvider provider = SpaceProvider();

  SpaceRepository._internal();
  static final SpaceRepository _getInstance = SpaceRepository._internal();
  static SpaceRepository get getInstance => _getInstance;

  Future<ApiWrapper<SpaceDto>> createNewSpaces(String groupName) async {
    var data = await provider.createNewSpace(groupName);

    if (data.success) {
      return ApiWrapper.success(
          data: SpaceDto.fromJson(json.decode(data.result.toString())));
    } else {
      return ApiWrapper.failure(error: data.error.toString());
    }
  }

  Future<ApiWrapper<SpaceDto>> chcekValidSpace(String groupName) async {
    var data = await provider.chcekValidSpace(groupName);

    if (data.success && data.result != null) {
      return ApiWrapper.success(
          data: SpaceDto.fromJson(json.decode(data.result[0].toString())));
    } else {
      return ApiWrapper.failure(error: data.error.toString());
    }
  }

  Future<ApiWrapper<List<SpaceDto>>> getWorkspaceList() async {
    var apiResponse = await provider.getSpaceList();

    if (apiResponse.success && apiResponse.results != null) {
      List<SpaceDto> items = [];

      List item = apiResponse.results as List<ParseObject>;
      item.forEach((element) {
        items.add(SpaceDto.fromJson(json.decode(element.toString())));
      });

      return ApiWrapper.success(data: items);
    } else {
      return ApiWrapper.failure(error: apiResponse.error.toString());
    }
  }
}
