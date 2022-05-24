import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:flutter_app/HomePage/HomePage.dart';
import 'Foundation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (isIos) {
    //   return CupertinoApp(
    //       theme: CupertinoThemeData(
    //           barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    //           primaryColor: CupertinoColors.destructiveRed),
    //       home: HomePage(),
    //   );
    // }
    // else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
    // }
  }
}