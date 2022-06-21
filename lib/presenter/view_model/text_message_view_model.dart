part of '../screen/text_message.dart';

class TextMessageViewModel
    extends BaseViewModel<_TextMessageState, TextMessageState> {
  TextMessageViewModel({required super.view});

  @override
  onSuccess(TextMessageState state) {
    view._bloc.loadMessages();
    view._controller.clear();
  }

  @override
  onFailuer(TextMessageState state) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('چیزی برای نمایش وجود ندارن'),
    ));
  }
}
