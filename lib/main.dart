import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:share_space/core/const/pref_key.dart';
import 'package:share_space/data/hive/entity/space_entity.dart';
import 'package:share_space/presenter/screen/start_screen.dart';
import 'package:share_space/textUi.dart';
import 'package:share_space/util/bloc_obs.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presenter/screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SpaceEntityAdapter());

  await Hive.openBox(MAIN_BOX);

  final keyApplicationId = 'vaCD0jtOIq0pjw3TcraHmkaWMng66rHoTqZowGpI';
  final keyClientKey = 'm9jYu1xDYV966PTe3YL5ATPSNxscrwghDWICnAG1';
  final keyParseServerUrl = 'https://parseapi.back4app.com/';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  BlocOverrides.runZoned(
    () => runApp(const MyWidget()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Dana',
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          })),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/login': (context) => StartScreen()
      },
    );
  }
}
