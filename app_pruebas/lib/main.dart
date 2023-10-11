import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:app_pruebas/MongoDBModel.dart';
import 'package:app_pruebas/dbHelper/mongodb.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await MongoDatabase.connect();
    print("Conexión exitosa a MongoDB Atlas");
  } catch (e) {
    print("Error al conectar a MongoDB Atlas: $e");
  }

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String qrValue = "Codigo QR";
  bool isImagePickerActive = false;

 void scanQR() async {
  if (isImagePickerActive) {
    // Evita iniciar una nueva selección de imágenes mientras ya está activa
    print('La selección de imágenes ya está activa.');
    return;
  }

  try {
    isImagePickerActive = true; // Marca la selección de imágenes como activa
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('Nada seleccionado.');
      return;
    }

    final galleryScanResult = await scanner.scanPath(pickedFile.path);
    print('Contenido del QR escaneado desde la galería: $galleryScanResult');

    if (galleryScanResult == null || !isJson(galleryScanResult)) {
      print('QR no válido');
      mostrarMensaje('QR no válido');
      return;
    }

    try {
      final decodedData = json.decode(galleryScanResult);

      if (decodedData is Map<String, dynamic> && decodedData.containsKey('email')) {
        final email = decodedData['email'];

        await MongoDatabase.connect();
        MongoDbModel? user = await MongoDatabase.getUserByEmail(email);

        if (user != null) {
          print('Usuario encontrado.');
          mostrarMensaje('Usuario existente: Conectado a la máquina');
        } else {
          print('Usuario no encontrado.');
          mostrarMensaje('Usuario no encontrado');
        }
      } else {
        print('El QR no contiene datos válidos.');
        mostrarMensaje('QR no válido');
      }
    } catch (e) {
      print('Error al decodificar o procesar QR: $e');
      mostrarMensaje('Error al decodificar el QR');
    }
  } catch (e) {
    print('Error al escanear QR: $e');
  } finally {
    isImagePickerActive = false; // Restablece la variable de control
  }
}

  bool isJson(String input) {
  try {
    final jsonData = json.decode(input);
    return jsonData is Map<String, dynamic>;
  } catch (e) {
    return false;
  }
}

  void mostrarMensaje(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR scan',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'QR scan',
          ),
        ),
        body: Center(
          child: Container(
            child: Text(
              qrValue,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () => scanQR(),
          child: Icon(
            Icons.camera,
          ),
        ),
      ),
    );
  }
}
