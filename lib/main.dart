import 'package:eco_localiza/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/start_screen.dart';
import 'view/user/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'startScreen',
    theme: FlexThemeData.light(scheme: FlexScheme.greenM3),
    darkTheme: FlexThemeData.dark(scheme: FlexScheme.greenM3),
    themeMode: ThemeMode.system,
    getPages: [
      GetPage(name: '/startScreen', page: ()=> StartScreen()),
      GetPage(name: '/loginScreen', page: ()=> LoginScreen()),
    ],
  ));
}