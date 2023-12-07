import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class FirebaseRegister {
  final BuildContext context;
  FirebaseRegister(this.context);

  Future<void> reguser(
      String name,
      String email,
      String cnpj,
      String phone,
      String password,
      ) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        await FirestoreService.saveuser(
          FirebaseFirestore.instance,
          name,
          user.uid,
          email,
          cnpj,
          phone,
        );
        Get.toNamed('/loginScreen');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }
}

class FirestoreService {
  static Future<void> saveuser(
      FirebaseFirestore firestore,
      String name,
      String userId,
      String email,
      String cnpj,
      String phone) async {
    try {
      await firestore.collection('user').doc().set({
        'name': name,
        'email': email,
        'user_id': userId,
        'cnpj': cnpj,
        'phone': phone,
      });
      Get.toNamed('/loginScreen');
    } catch (e) {
      print('Erro: $e');
    }
  }
}

class ResetPassword {
  final BuildContext context;
  ResetPassword(this.context);
  Future<void> resetpassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.offNamed('/loginScreen');
      Get.snackbar(
        'Redefinição de Senha',
        'Um e-mail de redefinição foi enviado para $email',
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Erro: $e');
      Get.snackbar(
        'Erro ao Redefinir Senha',
        'Ocorreu um erro ao enviar o e-mail de redefinição de senha. Por favor, tente novamente.',
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}