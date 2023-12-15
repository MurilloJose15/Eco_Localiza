import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eco_localiza/model/company/mod_company.dart';
import 'package:eco_localiza/view/components/custom_material_banner.dart';


class CtrlCompany extends GetxController {
  

  var companies = <Company>[].obs;

  List<String> get Trash_type => [
    "solventes",
    "embalagens de agrotóxicos",
    "pilhas",
    "baterias",
    "agulhas",
    "seringas",
  ];


  Future<void> registerCompany(Company company) async {
    try{
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(company.id)
          .set(company.toMap());
    }catch (e) {
      print('Erro: $e');
    } finally {
      Get.back();
    }
  }

  Future<void> saveCompanies({
    required String company_name,
    required List<String> trash_type,
    required String address,
    required String Lat,
    required String Lng,
    required String userId,
  }) async {
    if (company_name.isNotEmpty && address.isNotEmpty && Lat.isNotEmpty && Lng.isNotEmpty) {
      Company newCompany = Company(
          id: FirebaseFirestore.instance.collection('companies').doc().id,
          company_name: company_name,
          trash_type: trash_type,
          address: address,
          Lat: double.parse(Lat),
          Lng: double.parse(Lng),
          userId: userId,
      );
      await registerCompany(newCompany);
      Get.back();
    } else {
      if (kDebugMode) {
        print("Informações inválidas");
      }
    }
  }

  Future<List<Map<String, dynamic>>?> listCompanies() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('companies').get();

      return querySnapshot.docs
          .map((doc) => doc.data())
          .toList();
    }catch (e) {
      print('Erro ao listar empresas: $e');
      return null;
    }
  }

  Future<void> updateCompany(context, Company company) async {
    try{
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(company.id)
          .update(company.toMap());
      await listCompanies();
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar empresa: $e');
        CustomMaterialBanner(context, 'Erro ao atualizar empresa', Colors.red);
      }
    }
  }

  Future<void> removeCompany(Company company) async {
    try{
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(company.id)
          .delete();
      companies.remove(company);
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao remover a empresa: $e');
      }
    }
  }
}