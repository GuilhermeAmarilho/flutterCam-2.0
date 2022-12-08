// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'aplicativo.dart';
import 'voce.dart';

class Fotos extends StatefulWidget {
  const Fotos({super.key});
  @override
  State<Fotos> createState() => _FotosState();
}

class _FotosState extends State<Fotos> {
  int _selectedIndex = 0;
  final photos = <File>[];

  void openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          onFile: (file) {
            GallerySaver.saveImage(
              file.path,
            );
            photos.add(
              file,
            );
            Navigator.pop(
              context,
            );
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(201, 130, 223, 120),
        elevation: 1,
        title: const Text('Sua area de fotos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: photos.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width,
            child: Image.file(
              photos[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(201, 130, 223, 120),
      floatingActionButton: FloatingActionButton(
        onPressed: openCamera,
        child: const Icon(Icons.camera_alt),
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
        backgroundColor: const Color.fromARGB(201, 130, 223, 120),
      ),
    );
  }
}
