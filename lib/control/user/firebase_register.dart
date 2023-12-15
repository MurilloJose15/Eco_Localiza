import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:eco_localiza/view/components/custom_material_banner.dart';



class FirebaseRegister {
  final BuildContext context;

  FirebaseRegister(this.context);

  Future<void> reguser(String name,
      String email,
      String cnpj,
      String phone,
      String password,) async {
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
      }
      Get.offAllNamed('/loginScreen');
    } on FirebaseAuthException catch (e) {
      // Tratar o erro de acordo com o código de erro
      print(e.code);
      switch (e.code) {
        case 'email-already-in-use':
          CustomMaterialBanner(context, 'Email em uso', Colors.red);
          break;
        default:
          CustomMaterialBanner(context, 'Algo inexperado ocorreu, tente mais tarde', Colors.yellow);
          break;
      }
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
    } catch (e) {
      print('Erro: $e');
    }
  }
}