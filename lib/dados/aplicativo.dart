// ignore_for_file: unnecessary_string_interpolations, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'voce.dart';
import 'fotos.dart';

class Aplicativo extends StatefulWidget {
  const Aplicativo({super.key});
  @override
  State<Aplicativo> createState() => _AplicativoState();
}

class _AplicativoState extends State<Aplicativo> {
  int _selectedIndex = 2;

  Widget buildFirstTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'FlutterCamera',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildAutor() {
    return Column(
      children: const <Widget>[
        Text(
          'Desenvolvido por:',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Guilherme Amarilho',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildFlutter() {
    return Column(
      children: const <Widget>[
        Text(
          'Programado em:',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Dart / Flutter',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildCoop() {
    return Column(
      children: const <Widget>[
        Text(
          'Coordenador:',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Fabricio Bizzoto',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildClass() {
    return Column(
      children: const <Widget>[
        Text(
          'Matéria:',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Linguagem de programação 3',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
      ],
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
                    Color.fromARGB(204, 241, 224, 40),
                    Color.fromARGB(187, 84, 27, 216),
                    Color.fromARGB(133, 57, 28, 124),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildFirstTitle(),
                    const SizedBox(height: 50),
                    buildAutor(),
                    const SizedBox(height: 25),
                    buildClass(),
                    const SizedBox(height: 25),
                    buildCoop(),
                    const SizedBox(height: 25),
                    buildFlutter(),
                    const SizedBox(height: 25),
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
        backgroundColor: const Color.fromARGB(133, 57, 28, 124),
      ),
    );
  }
}
