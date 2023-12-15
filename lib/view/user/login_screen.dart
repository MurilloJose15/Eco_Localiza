import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:eco_localiza/control/user/firebase_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    FirebaseLogin firebaseLogin = FirebaseLogin(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/logotipo.png'))),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'EcoLocaliza',
                      style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(74,223,103,1.000)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Faça seu Login',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 8, 24, 0),
                        child: TextFormField(
                          controller: _emailController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Email é Obrigatório'),
                            EmailValidator(errorText: 'Insira um email Válido'),
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'A Senha é obrigatória'),
                            MinLengthValidator(6,
                                errorText:
                                    'A Senha deve ser maior que 6 caracteres'),
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.offAllNamed('/resetScreen');
                            },
                            child: Text(
                              'esqueceu a senha?',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromRGBO(74,223,103,1.000)),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
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
                            onPressed: () {
                              Get.toNamed('/registerScreen');
                            },
                            child: Text(
                              'Cadastre-se',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
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
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                firebaseLogin.firebaseLogin(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              }
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                minimumSize: Size(170, 38),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(
                                    color: Color.fromRGBO(74,223,103,1.000),
                                    width: 2,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed('/startScreen');
                              },
                              child: Text(
                                'Voltar',
                                style: TextStyle(
                                  color: Color.fromRGBO(74,223,103,1.000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
