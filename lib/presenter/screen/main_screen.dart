import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_space/core/const/pref_key.dart';
import 'package:share_space/data/enums/messsage_type.dart';
import 'package:share_space/data/repository/message_repository.dart';
import 'package:share_space/presenter/screen/text_message.dart';
import 'start_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // _isLogin();
    super.initState();
  }

  // _isLogin() {
  //   if (!Hive.box(MAIN_BOX).containsKey(HiveData.spaceId)) {
  //     Navigator.of(context).pushNamed(
  //         '/login');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            width: 500,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'سلام بچه‌ها',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
                const Text(
                    'خوب امیدوارم که خوب باشید اینجا میتونید با هم دیگه فایلها و متن‌های خودتون رو به اشتراک بزارید و در طرف دیگه دریافتشون کنید.'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => TextMessage(
                                    repository: MessageRepository.getInstance,
                                    type: MessageType.file)));
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 140,
                            height: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.file_present_outlined),
                          ),
                          const Text('فضای فایلها',
                              style: TextStyle(fontWeight: FontWeight.w700))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => TextMessage(
                                      repository: MessageRepository.getInstance,
                                      type: MessageType.text,
                                    )));
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 140,
                            height: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.file_present_outlined),
                          ),
                          const Text(
                            'فضای متنی',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () async {
                    Hive.box(MAIN_BOX).deleteFromDisk();
                    await Hive.openBox(MAIN_BOX);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (x) => StartScreen()),
                        (route) => false);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    width: double.infinity,
                    height: 52,
                    child: const Text(
                      'خارح شدن از اتاق',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
