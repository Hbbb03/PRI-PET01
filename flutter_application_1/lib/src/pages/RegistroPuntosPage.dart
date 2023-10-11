import 'package:flutter/material.dart';
import 'package:flutter_application_1/MongoDBModel.dart';
import 'package:flutter_application_1/dbHelper/mongodb.dart';

class RegistroPuntosPage extends StatefulWidget {
  final String username;

 RegistroPuntosPage({this.username = "", Key? key}) : super(key: key);

  @override
  _RegistroPuntosPageState createState() => _RegistroPuntosPageState();
}

class _RegistroPuntosPageState extends State<RegistroPuntosPage> {
  List<MongoDbModel> userRecords = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // Conecta a la base de datos de MongoDB Atlas
      await MongoDatabase.connect();

      // Obtén los registros del usuario actual
      List<MongoDbModel> records =
          await MongoDatabase.getUserRecords(widget.username);

      setState(() {
        userRecords = records;
      });
    } catch (e) {
      print('Error al cargar datos desde MongoDB: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Puntos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registros de Puntos para ${widget.username}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            if (userRecords.isNotEmpty)
              DataTable(
                columns: [
                  DataColumn(label: Text('Peso (g)')),
                  DataColumn(label: Text('Puntos')),
                  DataColumn(label: Text('Fecha')),
                ],
                rows: userRecords
                    .map((record) => DataRow(
                          cells: [
                            DataCell(Text(record.peso.toString())),
                            DataCell(Text(record.puntos.toString())),
                            DataCell(Text(record.fecha.toLocal().toString())),
                          ],
                        ))
                    .toList(),
              ),
            if (userRecords.isEmpty)
              Text('No se encontraron registros de puntos para ${widget.username}'),
          ],
        ),
      ),
    );
  }
}
