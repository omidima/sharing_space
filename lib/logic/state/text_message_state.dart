part of '../cubit/text_message_cubit.dart';

abstract class TextMessageState {}

class TextMessageInitState extends TextMessageState {}

class TextMessageLoadedMessages extends TextMessageState {
  List<MessageDto> messages;
  TextMessageLoadedMessages(this.messages);
}

class TextMessageErrorState extends TextMessageState {
  String? message;
  TextMessageErrorState({this.message});
}

class NeedRefreshPage extends TextMessageState {}
