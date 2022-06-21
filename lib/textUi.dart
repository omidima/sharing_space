import 'package:flutter/material.dart';
import 'package:share_space/presenter/widget/file_item_view.dart';

class TestUi extends StatelessWidget {
  const TestUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FileItemView(
          fileName: 'ihavirlhaerv.mp4',
          fileSize: '12',
          isLoading: false,
        ),
      ),
    );
  }
}
