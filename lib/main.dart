import 'package:eco_localiza/view/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'view/start_screen.dart';
import 'view/user/login_screen.dart';
import 'view/user/register_screen.dart';
import 'view/company/company_screen.dart';
import 'view/company/register_company_screen.dart';
import 'firebase_options.dart';
import 'view/user/reset_password.dart';


// void main(){
//   runApp(MaterialApp(
//       home: GoogleAutoComplete(),
//   ));
// }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'startScreen',
    themeMode: ThemeMode.system,
    getPages: [
      GetPage(name: '/startScreen', page: ()=> StartScreen()),
      GetPage(name: '/loginScreen', page: ()=> LoginScreen()),
      GetPage(name: '/registerScreen', page: ()=> RegisterScreen()),
      GetPage(name: '/resetScreen', page: ()=> ResetPassScreen()),
      GetPage(name: '/companyScreen', page: ()=> CompanyScreen()),
      GetPage(name: '/regCompScreen', page: ()=> RegisterCompanyScreen()),
      GetPage(name: '/homeScreen', page: ()=> HomeScreen()),
    ],
  ));
}
