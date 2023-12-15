import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:eco_localiza/view/components/custom_material_banner.dart';

class FirebaseLogin {
  final BuildContext context;
  FirebaseLogin(this.context);
  Future<void> firebaseLogin(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
      );
      Get.offAllNamed('/companyScreen');
    } catch (e) {
      print('Senha incorreta');
      CustomMaterialBanner(context,
          'Credenciais inválidas, tente novamente ou cadastre-se!', Colors.red);
    }
  }
}