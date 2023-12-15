import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResetPassword {
  final BuildContext context;

  ResetPassword(this.context);

  Future<void> resetpassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.offAllNamed('/loginScreen');
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