// ignore_for_file: camel_case_types, library_private_types_in_public_api, unused_element, import_of_legacy_library_into_null_safe, unused_import, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'voce.dart';
import 'cadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  String _login = "";
  String _senha = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _leLogin();
    _lesenha();
    super.initState();
  }

  _leLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('login') != null) {
      setState(
        () {
          _login = (prefs.getString('login'))!;
        },
      );
    }
  }

  _lesenha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('senha') != null) {
      setState(
        () {
          _senha = prefs.getString('senha')!;
        },
      );
    }
  }

  Widget buildLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          height: 60,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email, color: Color(0xff348feb)),
              hintText: 'Informe seu login: ',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Senha',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Color(0xff348feb)),
                hintText: 'Informe sua senha:',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(25),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Log In',
          style: TextStyle(
            color: Color(0xff348feb),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => {
          if (emailController.text != "" && passwordController.text != "")
            {
              if (_login == emailController.text &&
                  _senha == passwordController.text)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Voce()),
                  )
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cadastro()),
                  )
                }
            }
        },
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Cadastro()),
        )
      },
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
            text: 'Não possui conta? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'Cadastre-se',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 247, 128, 128),
                      Color(0xcc348feb),
                      Color.fromARGB(255, 23, 60, 97),
                    ])),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Faça seu Login',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      buildLogin(),
                      const SizedBox(height: 20),
                      buildPassword(),
                      const SizedBox(height: 10),
                      buildLoginBtn(),
                      buildSignUpBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
