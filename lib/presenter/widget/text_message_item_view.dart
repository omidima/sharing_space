import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share/share.dart';
import 'package:share_space/data/dto/workspace_item_dto.dart';
import 'package:toast/toast.dart';

class TextMessageItemView extends StatelessWidget {
  MessageDto message;
  TextMessageItemView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(8).copyWith(top: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.sender!,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 20,
          ),
          Text(message.body!),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Share.share(message.body!);
                },
                child: const Icon(Icons.share),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: message.body));
                  ToastContext().init(context);
                  Toast.show('متن کپی شد.');
                },
                child: const Icon(Icons.copy),
              )
            ],
          ),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }
}
