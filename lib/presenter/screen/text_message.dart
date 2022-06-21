import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:share_space/core/const/pref_key.dart';
import 'package:share_space/data/dto/workspace_item_dto.dart';
import 'package:share_space/data/enums/messsage_type.dart';
import 'package:share_space/data/hive/entity/space_entity.dart';
import 'package:share_space/data/repository/message_repository.dart';
import 'package:share_space/logic/cubit/text_message_cubit.dart';
import 'package:share_space/presenter/widget/file_item_view.dart';
import 'package:share_space/presenter/widget/text_message_item_view.dart';

import '../../core/base_view_model.dart';
import '../../data/dto/space_dto.dart';
part '../view_model/text_message_view_model.dart';

class TextMessage extends StatefulWidget {
  MessageRepository repository;
  MessageType type;

  TextMessage({required this.repository, required this.type});
  @override
  State createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  late TextMessageCubit _bloc;
  late TextMessageViewModel viewModel;

  SpaceEntity spaceDto = Hive.box(MAIN_BOX).get(HiveData.spaceInfo);
  TextEditingController _controller = TextEditingController();
  bool isValue = false;

  @override
  void initState() {
    _bloc = TextMessageCubit(
        messageRepository: widget.repository, type: widget.type);
    viewModel = TextMessageViewModel(view: this);

    _controller.addListener(() {
      if (!isValue && _controller.text.isNotEmpty) {
        setState(() {
          isValue = true;
        });
      } else if (isValue && _controller.text.isEmpty) {
        setState(() {
          isValue = false;
        });
      }
    });
    _bloc.loadMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<TextMessageCubit, TextMessageState>(
        listener: (context, state) {
          if (state is TextMessageErrorState) {
            viewModel.onFailuer(state);
          }

          if (state is NeedRefreshPage) {
            viewModel.onSuccess(state);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.amber,
          body: Center(
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(8),
                constraints: const BoxConstraints(
                    maxWidth: 500,
                    minWidth: 300,
                    maxHeight: double.infinity,
                    minHeight: double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16.0, right: 8),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child:
                                      const Icon(Icons.arrow_back_ios_rounded),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 8, top: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  "نام اتاق: ${spaceDto.group_name.toString()}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0, left: 16),
                            child: Text(widget.type == MessageType.text
                                ? "فضای متنی"
                                : "فایلهای اناق"),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: _messageList(),
                    ),
                    _messageInput()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _messageList() {
    return BlocBuilder<TextMessageCubit, TextMessageState>(
      builder: (context, state) {
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            if (_bloc.items[index].type == MessageType.file.value) {
              return FileItemView(
                fileName: _bloc.items[index].files!.file_name.toString(),
                fileSize: _bloc.items[index].files!.file_size.toString(),
                isLoading: _bloc.items[index].objectId == 'uploading',
              );
            } else {
              return TextMessageItemView(
                message: _bloc.items[index],
              );
            }
          },
          itemCount: _bloc.items.length,
        );
      },
    );
  }

  _messageInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                blurRadius: 8,
                color: Color.fromARGB(21, 0, 0, 0),
                offset: Offset(0, 1))
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              maxLines: 3,
              minLines: 3,
              decoration: const InputDecoration(border: InputBorder.none)
                  .copyWith(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4)),
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: FittedBox(
                child: widget.type == MessageType.text
                    ? MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.amberAccent,
                        minWidth: 70,
                        height: 80,
                        onPressed: () {
                          _controller.text.isEmpty
                              ? () {}
                              : _bloc.createNewMessage(
                                  _controller.text, null, null);
                        },
                        child: Icon(
                          widget.type == MessageType.file
                              ? Icons.attach_file
                              : Icons.send_rounded,
                          color: Colors.deepPurpleAccent,
                        ),
                      )
                    : MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.amberAccent,
                        minWidth: 70,
                        height: 80,
                        onPressed: _controller.text.isNotEmpty
                            ? () {
                                _bloc.createNewMessage(
                                    _controller.text, null, null);
                              }
                            : () {
                                _bloc.uploadFiles();
                              },
                        child: Icon(
                          _controller.text.isEmpty
                              ? Icons.attach_file
                              : Icons.send_rounded,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
              ))
        ],
      ),
    );
  }
}
