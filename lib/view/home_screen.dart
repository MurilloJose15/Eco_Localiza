import 'package:eco_localiza/control/company/ctrl_company.dart';
import 'package:eco_localiza/model/company/mod_company.dart';
import 'package:eco_localiza/services/google/maps.dart';
import 'package:eco_localiza/view/company/edit_company_screen.dart';
import 'package:eco_localiza/view/start_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:eco_localiza/view/components/custom_appbar.dart';
import 'package:eco_localiza/view/components/custom_material_banner.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CtrlCompany ctrlCompany = Get.put(CtrlCompany());

  List<Map<String, dynamic>> registedCompanies = [];

  @override
  void initState() {
    super.initState();
    listCompanies();
  }

  Future<void> listCompanies() async {
    final companies = await CtrlCompany()
        .listCompanies(); // Suponha que esta função liste as salas no Firebase
    if (companies != null) {
      setState(() {
        registedCompanies = companies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      ctrlCompany.listCompanies();
    });
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Empresas',
      ),
      body: ListView.builder(
          itemCount: registedCompanies.length,
          itemBuilder: (context, index) {
            final company = registedCompanies[index];
            String teste = company['trash_type'].join(', ');
            return GestureDetector(
              onTap: () {
                print(company['Lat']);
                print(company['Lng']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleMapsAdress(
                      latitude: company['Lat'],
                      longitude: company['Lng'],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ListTile(
                    title: Text(company['company_name'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tipo de lixo: ${teste}",
                          maxLines: 2,
                        ),
                        Text(
                          "Endereço: ${company['address']}",
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
