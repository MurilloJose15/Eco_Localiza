import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserController extends GetxController {
  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  @override
  void onInit() {
    super.onInit();
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
  }
}

class FirebaseLogin {
  final BuildContext context;
  FirebaseLogin(this.context);
  Future<void> BaseLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      Get.toNamed('/companyScreen');
    } catch (e) {
      print('Erro: $e');
    }
  }
}