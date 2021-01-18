import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  await translator.init(
      localeDefault: LocalizationDefaultType.device,
      language: 'en',
      languagesList: <String>['en' ,  'my'],
      assetsDirectory: 'languages'
  );
  await Firebase.initializeApp();
  SharedPreferences.setMockInitialValues({});
  runApp(LocalizedApp(child: ILoveLiquor()));
}

class ILoveLiquor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          backgroundColor: darkGreenColor
        )
      ),

      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: '"I Love Liquor Minagalar Par"',
      home: FirstPage(),
      locale: translator.locale,
      supportedLocales: translator.locals(),

    );
  }
}
