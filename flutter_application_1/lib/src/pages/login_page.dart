import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/menu.dart'; // Importa la página 'menu.dart'

class LoginPage extends StatefulWidget {
  static const String id =
      'login_page'; // Debes usar 'static const' para inicializar la variable

  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inicio de Sesión'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                'assets/logoPrincipal.png',
                width:
                    200, // Ajusta el tamaño de la imagen según tus necesidades
                height: 200,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true, // Para ocultar la contraseña
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Navegar a la página 'menu.dart' cuando se presione el botón
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage()), // Asegúrate de que el nombre de la clase de la página sea 'MenuPage'
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
            ],
          ),
        ),
      ),
    );
  }
}
