// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  bool _verSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              label: Text('E-mail'),
              hintText: 'nome@email.com',
            ),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Digite seu e-mail';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _senhaController,
            obscureText: _verSenha,
            decoration: InputDecoration(
              label: const Text('Senha'),
              hintText: 'Digite sua senha',
              suffixIcon: IconButton(
                icon: Icon(
                  _verSenha
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _verSenha = !_verSenha;
                  });
                },
              ),
            ),
            validator: (senha) {
              if (senha == null || senha.isEmpty) {
                return 'Digite sua senha';
              } else if (senha.length < 6) {
                return 'Digite uma senha melhor';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              // if (_formKey.currentState!.validate()) {
              logar();
              // }
            },
            child: const Text(
              'Entrar',
            ),
          )
        ],
      ),
      // body: Center(
      //   child: SingleChildScrollView(
      //     padding: const EdgeInsets.all(50),
      //     child: Form(
      //       key: _formKey,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: [
      //           TextFormField(
      //             controller: _emailController,
      //             keyboardType: TextInputType.emailAddress,
      //             decoration: const InputDecoration(
      //               label: Text('E-mail'),
      //               hintText: 'nome@email.com',
      //             ),
      //             validator: (email) {
      //               if (email == null || email.isEmpty) {
      //                 return 'Digite seu e-mail';
      //               }
      //               return null;
      //             },
      //           ),
      //           TextFormField(
      //             controller: _senhaController,
      //             obscureText: _verSenha,
      //             decoration: InputDecoration(
      //               label: const Text('Senha'),
      //               hintText: 'Digite sua senha',
      //               suffixIcon: IconButton(
      //                 icon: Icon(
      //                   _verSenha
      //                       ? Icons.visibility_outlined
      //                       : Icons.visibility_off_outlined,
      //                 ),
      //                 onPressed: () {
      //                   setState(() {
      //                     _verSenha = !_verSenha;
      //                   });
      //                 },
      //               ),
      //             ),
      //             validator: (senha) {
      //               if (senha == null || senha.isEmpty) {
      //                 return 'Digite sua senha';
      //               } else if (senha.length < 6) {
      //                 return 'Digite uma senha melhor';
      //               }
      //               return null;
      //             },
      //           ),
      //           const SizedBox(
      //             height: 30,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               if (_formKey.currentState!.validate()) {
      //                 logar();
      //               }
      //             },
      //             child: const Text(
      //               'Entrar',
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  logar() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _senhaController.text,
      );
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Usuário não encontrado'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Senha incorreta'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    //   SharedPreferences _sharedPreferences =
    //       await SharedPreferences.getInstance();
    //   var url = Uri.parse("https://emanuelseverino.com.br/login/");
    //   var response = await http.post(
    //     url,
    //     body: {
    //       'username': _emailController.text,
    //       'password': _senhaController.text
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     String token = jsonDecode(response.body)['token'];
    //     // json.decode(response.body)['token'];
    //     await _sharedPreferences.setString('token', 'Authorization $token');
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => CheckPage(),
    //       ),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         backgroundColor: Colors.redAccent,
    //         content: Text('Email ou senha inválidos'),
    //         behavior: SnackBarBehavior.floating,
    //       ),
    //     );
    //   }
  }
}
