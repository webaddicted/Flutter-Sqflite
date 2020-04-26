import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:fluttersqflite/global/constant/assets_constant.dart';
import 'package:fluttersqflite/global/constant/color_constant.dart';
import 'package:fluttersqflite/global/constant/string_constant.dart';
import 'package:fluttersqflite/view/login/onboarding.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StrConstant.APP_NAME,
      debugShowCheckedModeBanner: false,
//      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        fontFamily: AssetsConstant.ZILLASLAB_FONT,
        accentColor: ColorConstant.APP_COLOR,
        accentColorBrightness: Brightness.light,
        primarySwatch: ColorConstant.APP_COLOR,
      ),
      home: OnboardingScreen(),
    );
  }
}
