import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_space/core/const/pref_key.dart';
import 'package:share_space/data/dto/file_dto.dart';
import 'package:share_space/data/enums/messsage_type.dart';
import 'package:share_space/data/repository/message_repository.dart';

import '../../data/dto/workspace_item_dto.dart';
part '../state/text_message_state.dart';

class TextMessageCubit extends Cubit<TextMessageState> {
  TextMessageCubit({required this.messageRepository, required this.type})
      : super(TextMessageInitState());
  MessageRepository messageRepository;
  MessageType type;
  List<MessageDto> items = [];

  loadMessages() async {
    var result = await messageRepository.getSpaceMessage(
        Hive.box(MAIN_BOX).get(HiveData.spaceId), type);

    result.when(success: (data) {
      items = data;
      emit(TextMessageLoadedMessages(items));
    }, failure: (data) {
      emit(TextMessageErrorState(message: data));
    });
  }

  createNewMessage(String? value, ParseObject? file, MessageType? type) async {
    if (value != null) {
      var result = await messageRepository.createMessage(
          MessageDto(
              sender: Hive.box(MAIN_BOX).get(HiveData.username),
              type: type == MessageType.text
                  ? MessageType.text.value
                  : MessageType.file.value,
              body: value),
          file);

      result.when(
          success: (success) => emit(NeedRefreshPage()),
          failure: (data) => print('no send message ${data}'));
    }
  }

  uploadFiles() async {
    if (await Permission.storage.isDenied || await Permission.photos.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.photos,
      ].request();
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      ParseFileBase? parseFile;
      File file = File(result.files[0].path!);

      if (Platform.isFuchsia) {
        //Flutter Web
        parseFile = ParseWebFile(
          file.readAsBytesSync(),
          name: file.path.split('/').last,
        ); //Name for file is required
      } else {
        //Flutter Mobile/Desktop
        parseFile = ParseFile(file);
      }
      
      items.add(MessageDto(
          files: FileDto(
              file_name: file.path.split('/').last,
              file_size: file.lengthSync().toString()),
          type: MessageType.file.value,
          objectId: 'uploading'));
      emit(TextMessageInitState());

      ParseResponse r = await parseFile.save();

      final gallery = ParseObject('files')
        ..set('file_address', r.result.url)
        ..set('file_size', file.lengthSync().toString())
        ..set('file_name', r.result.name);
      var file_upload = await gallery.save();

      createNewMessage(' ', file_upload.result, MessageType.file);
    }
  }
}
