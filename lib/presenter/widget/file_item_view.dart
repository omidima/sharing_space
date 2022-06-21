import 'package:flutter/material.dart';

class FileItemView extends StatelessWidget {
  FileItemView(
      {Key? key,
      required this.fileName,
      required this.fileSize,
      this.isLoading = false})
      : super(key: key);
  String fileName;
  String fileSize;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurRadius: 10,
                color: Color.fromARGB(5, 0, 0, 0),
                offset: Offset(0, 0))
          ],
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _fileIcon(),
                    const SizedBox(
                      width: 10,
                    ),
                    isLoading
                        ? Row(
                            children: const [
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('...upload', style: TextStyle(fontSize: 12))
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fileName),
                              Text(
                                fileSize,
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                  ],
                ),
              ),
              isLoading ? Container() : Icon(Icons.download)
            ],
          ),
        ],
      ),
    );
  }

  _fileIcon() {
    return Stack(
      children: [
        const SizedBox(width: 50, height: 40),
        Image.asset(
          'assets/file.png',
          width: 50,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.red),
            child: Text(
              fileName.split('.').last,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
