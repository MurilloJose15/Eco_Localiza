import 'package:flutter/material.dart';

import 'package:eco_localiza/view/components/custom_appbar.dart';

import 'package:eco_localiza/view/components/custom_drawer.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Minhas Empresas',
        ),
        drawer: CustomDrawer(),
        body: Center(
          child: Text('Continua'),
        ));
  }
}
