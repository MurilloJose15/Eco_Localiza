import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:eco_localiza/control/user/user_control.dart';
import 'package:eco_localiza/control/user/firebase_logout.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  FirebaseLogout firebaseLogout = FirebaseLogout();
  final UserController _userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(74, 223, 103, 1.000),
            ),
            accountName: Text(
              _userController.user?.displayName ?? '',
              style: GoogleFonts.roboto(
                fontSize: 16,
              ),
            ),
            accountEmail:
                Text(_userController.user?.email ?? 'No user logged un'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                _userController.user?.email?.isNotEmpty == true
                    ? _userController.user!.email![0].toUpperCase()
                    : '@',
                style: GoogleFonts.roboto(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Card(
            //color: Colors.black,
            child: ListTile(
              leading: Icon(
                Icons.add_box,
                color: Colors.black,
              ),
              title: Text(
                'Adicionar um empresa',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                ),
              ),
              onTap: (){
                Get.offNamed('/regCompScreen');
              },
            ),
          ),
          Card(
            //color: Colors.black,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text(
                'Sair',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                ),
              ),
              onTap: (){
                firebaseLogout.logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
