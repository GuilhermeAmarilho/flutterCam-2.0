// ignore_for_file: unnecessary_string_interpolations, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'aplicativo.dart';
import 'fotos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Voce extends StatefulWidget {
  const Voce({super.key});
  @override
  State<Voce> createState() => _VoceState();
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class _VoceState extends State<Voce> {
  int _selectedIndex = 1;

  String _login = "";
  String _nome = "";

  @override
  void initState() {
    _leLogin();
    _leNome();
    super.initState();
  }

  _leLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var login = (prefs.getString('login'))!;
      login = login.toCapitalized();
      login = login.toUpperCase();
      login = login.toTitleCase();
      _login = login;
    });
  }

  _removeConta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login');
    await prefs.remove('nome');
    await prefs.remove('senha');
  }

  _leNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome')!;
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget buildFirstTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Seus dados',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildName() {
    return Column(
      children: <Widget>[
        const Text(
          'Seu Nome:',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '$_nome',
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      children: <Widget>[
        const Text(
          'Seu Login:',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '$_login',
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Excluir conta',
          style: TextStyle(
            color: Color(0xff348feb),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => {
          _removeConta(),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cadastro()),
          )
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    Color.fromARGB(175, 93, 189, 226),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildFirstTitle(),
                    const SizedBox(height: 50),
                    buildName(),
                    const SizedBox(height: 30),
                    buildEmail(),
                    const SizedBox(height: 30),
                    buildLoginBtn()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.black,
                size: 30,
              ),
              label: 'Fotos',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              ),
              label: 'Você',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.create,
                color: Colors.black,
                size: 30,
              ),
              label: 'Aplicativo',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Fotos()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Voce()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Aplicativo()),
                );
                break;
            }
          },
          backgroundColor: const Color.fromARGB(175, 93, 189, 226)),
    );
  }
}
