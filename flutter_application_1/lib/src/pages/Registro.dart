import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_application_1/src/pages/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/MongoDBModel.dart';
import 'package:flutter_application_1/dbHelper/mongodb.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController confirmarContrasenaController =
      TextEditingController();

  void _registrarUsuario() async {
    // Validar campos vacíos
    if (nombreController.text.isEmpty ||
        correoController.text.isEmpty ||
        celularController.text.isEmpty ||
        contrasenaController.text.isEmpty ||
        confirmarContrasenaController.text.isEmpty) {
      mostrarError('Por favor, complete todos los campos.');
      return;
    }

    // Validar que las contraseñas coincidan
    if (contrasenaController.text != confirmarContrasenaController.text) {
      mostrarError('Las contraseñas no coinciden.');
      return;
    }

    // Llama a la función para registrar al usuario
    _insertData(
        nombreController.text, correoController.text, int.tryParse(celularController.text) ?? 0);
  }

  Future<void> _insertData(String nombres, String email, int numeroCelular) async {
    // Validar que los campos no estén vacíos
    if (nombres.isEmpty || email.isEmpty) {
      mostrarError('Por favor, complete todos los campos.');
      return;
    }

    // Crear un objeto MongoDbModel con los datos del formulario
  MongoDbModel userData = MongoDbModel(
  nombres: nombreController.text,
  email: correoController.text,
  numeroCelular: int.parse(celularController.text),
  contrasena: contrasenaController.text,
  rol: 'user',  // Rol como 'user' como se especificó
  estado: 1,     // Estado como 1 como se especificó
  fechaRegistro: DateTime.now(),         // Fecha de registro actual
  fechaActualizacion: DateTime.now(),     // Fecha de actualización actual
);


      // Añade otros campos de acuerdo a tu modelo si es necesario
    

    // Conectar a MongoDB Atlas y realizar la inserción de datos
    await MongoDatabase.connect();
    String result = await MongoDatabase.insert(userData);

    if (result == "Data Inserted") {
      // Datos insertados exitosamente
      // Puedes realizar acciones adicionales aquí si es necesario
      // Por ejemplo, mostrar un mensaje de éxito
      mostrarMensaje('Usuario registrado exitosamente.');

      // Guardar datos en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_qr_code', userData.toJson().toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRPage(data: userData.toJson().toString()),
          ),
        );
    } else {
      // Manejar el error, como mostrar un mensaje de error
      mostrarError('Error al registrar usuario: $result');
    }
  }

  void mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/logoPrincipal.png',
                width:
                    200, // Ajusta el tamaño de la imagen según tus necesidades
                height: 200,
              ),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextFormField(
                controller: celularController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Número de Celular'),
              ),
              TextFormField(
                controller: contrasenaController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
              TextFormField(
                controller: confirmarContrasenaController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_validateInput()) {
                    _registrarUsuario();
                    print("recibido");
                  }
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
      ),
    );
  }

  bool _validateInput() {
    if (nombreController.text.isEmpty ||
        correoController.text.isEmpty ||
        celularController.text.isEmpty ||
        contrasenaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, llene todos los campos')),
      );
      return false;
    }
    return true;
  }
}

class QRPage extends StatelessWidget {
  final String data;

  QRPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Codigo QR')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: data,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 151, 133, 230),
              ),
              child: Text('Ir a Home'),
            ),
          ],
        ),
      ),
    );
  }
}
