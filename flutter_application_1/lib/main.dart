import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/welcome_page.dart';
import 'src/pages/Registro.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// ignore: unused_import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // Color principal de la aplicación
      ),
      home: WelcomePage(), // Cambia la página inicial a WelcomePage
    );
  }
}
