import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:eco_localiza/control/user/user_control.dart';
import 'package:eco_localiza/validator/cnpj_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cnpjController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _cnpjMaskFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##', // Define a máscara do CNPJ
    filter: {'#': RegExp(r'[0-9]')}, // Define o filtro para aceitar apenas números
  );

  @override
  Widget build(BuildContext context) {

    FirebaseRegister firebaseRegister = FirebaseRegister(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
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
                      'Cadastro',
                      style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(69, 255, 101, 1.800)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 15, 24, 5),
                        child: TextFormField(
                          controller: _nameController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Campo obrigatório'),
                            MinLengthValidator(3,
                                errorText: 'O nome deve ter no mínimo 3 caracteres'),
                            MaxLengthValidator(50,
                                errorText: 'O nome deve ter no máximo 30 caracteres'),
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Nome',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 15, 24, 5),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 15, 24, 5),
                        child: TextFormField(
                          controller: _cnpjController,
                          inputFormatters: [_cnpjMaskFormatter],
                          decoration: InputDecoration(
                            hintText: 'CNPJ',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo CNPJ obrigatório';
                            }
                            return validarCNPJ(value!)
                                ? null
                                : 'CNPJ inválido'; // Retorna a mensagem de erro se o CNPJ for inválido
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 15, 24, 5),
                        child: TextFormField(
                          controller: _phoneController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Email é Obrigatório'),
                            EmailValidator(errorText: 'Insira um email Válido'),
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Telefone',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: Size(170, 38),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                  color: Color.fromRGBO(69, 255, 101, 1.000),
                                  width: 2,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed('/loginScreen');
                            },
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                color: Color.fromRGBO(69, 255, 101, 1.000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(69, 255, 101, 1.000),
                                minimumSize: Size(170, 38)),
                            onPressed: () {
                              firebaseRegister.reguser(
                                  _nameController.text,
                                  _emailController.text,
                                  _cnpjController.text,
                                  _phoneController.text,
                                  _passwordController.text);
                            },
                            child: Text(
                              'Cadastrar-se',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
