import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseLogout {
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/startScreen');
    } catch (e) {
      print('Erro: $e');
    }
  }
}