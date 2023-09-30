import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/Registro.dart';
import 'package:flutter_application_1/src/pages/login_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: use_key_in_widget_constructors
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'BIENVENIDO A LA PET APP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/logoPrincipal.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 57, 196, 29),
              ),
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla con el código QR
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCodeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Continuar como Anónimo'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registro()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 151, 133, 230),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QRCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String qrData = "Activar"; // Texto que se mostrará en el código QR

    return Scaffold(
      appBar: AppBar(
        title: Text('Código QR Anónimo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Escanea este código para activar la maquina',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
