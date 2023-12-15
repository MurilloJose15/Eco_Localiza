import 'package:eco_localiza/control/user/user_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:eco_localiza/control/company/ctrl_company.dart';
import 'package:eco_localiza/model/company/mod_company.dart';
import 'package:eco_localiza/view/components/custom_appbar.dart';
import 'package:eco_localiza/view/components/custom_drawer.dart';
import 'package:eco_localiza/services/google/google_autocomplete.dart';


class RegisterCompanyScreen extends StatefulWidget {
  const RegisterCompanyScreen({super.key});

  @override
  State<RegisterCompanyScreen> createState() => _RegisterCompanyScreenState();
}

class _RegisterCompanyScreenState extends State<RegisterCompanyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namecompanyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final UserController _userController = Get.put(UserController());

  double _latController = 0;
  double _lngController = 0;

  List<String> items = ['solventes', 'embalagens de agrotóxicos', 'baterias'];
  List<String> selectedItems = [];
  String? dropdownValue;
  TextEditingController customItemController = TextEditingController();

  final CtrlCompany ctrlCompany = Get.put(CtrlCompany());


  @override
  void dispose() {
    customItemController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Cadastrar empresa',
        ),
        drawer: CustomDrawer(),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _namecompanyController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Campo Obrigratório'),
                    MinLengthValidator(3,
                        errorText: 'O Nome deve ter no mínimo 3 caracteres'),
                    MaxLengthValidator(70,
                        errorText:
                            'O Nome deve conter no máximo 70 caracteres'),
                  ]),
                  decoration: InputDecoration(
                    hintText: 'Nome da Empresa',
                    labelText: 'Nome da Empresa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.3,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Text(
                                  'Endereço: ${_addressController.text}',
                                  maxLines: 7,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                            color: Color.fromRGBO(74, 223, 103, 1.000),
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final address = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleAutoComplete()),
                        );
                        if (address != null) {
                          setState(() {
                            _addressController.text = address['address'];
                            _latController = address['lat'];
                            _lngController = address['lng'];
                          });
                          print("$_addressController adressssss");
                          print("$_latController latituuuuu");
                          print("$_lngController longuituuuuu");
                        }
                      },
                      child: Text(
                        'Adicionar Endereço',
                        style: GoogleFonts.roboto(
                          color: Color.fromRGBO(74, 223, 103, 1.000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Material que recolhe: ',
                          maxLines: 2,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DropdownButton<String>(
                        hint: Text('Selecionar'),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            if (!selectedItems.contains(newValue)) {
                              selectedItems.add(newValue!);
                              print(selectedItems);
                            }
                          });
                        },
                        items:
                        items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(width: 20),
                      Wrap(
                        children: selectedItems.map<Widget>((String value) {
                          return Column(
                            children: [
                              Chip(
                                label: Text(value),
                                onDeleted: () {
                                  setState(() {
                                    selectedItems.remove(value);
                                  });
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Adicionar Item'),
                                content: TextFormField(
                                  controller: customItemController,
                                  decoration: InputDecoration(
                                    hintText: 'Novo item',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        String newItem =
                                        customItemController.text.trim();
                                        if (newItem.isNotEmpty &&
                                            !items.contains(newItem)) {
                                          items.add(newItem);
                                          dropdownValue = newItem;
                                          selectedItems.add(newItem);
                                        }
                                        customItemController.clear();
                                        Navigator.of(context).pop();
                                        print(selectedItems);
                                      });
                                    },
                                    child: Text('Adicionar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Adicionar Item não listado'),
                      ),
                    ],
                  ),
                ],
              ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 50,),
                  Padding(padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(74,223,103,1.000),
                        minimumSize: Size(170, 38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                            color: Color.fromRGBO(74,223,103,1.000),
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: _saveCompany,
                      child: Text('Confirmar Cadastro', style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _saveCompany() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String uid = user!.uid;

    Company newCompany = Company(
      id: FirebaseFirestore.instance.collection('companies').doc().id,
      company_name: _namecompanyController.text,
      trash_type: selectedItems,
      address: _addressController.text,
      Lat: _latController,
      Lng: _lngController,
      userId: uid,
    );
    await ctrlCompany.registerCompany(newCompany);
    Get.offAllNamed('/companyScreen');
    print(uid);
  }
}
