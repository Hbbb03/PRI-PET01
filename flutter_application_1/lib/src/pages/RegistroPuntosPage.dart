import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/menu.dart';

class RegistroPuntosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      body: Stack(
        children: [
          // Imagen de fondo con opacidad
          Opacity(
            opacity: 0.3, // Reduzco la opacidad para reducir el zoom
            child: Image.asset(
              'assets/Botella2.png', // Reemplaza con la ruta de tu imagen de fondo
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain, // Cambio a BoxFit.contain
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Opacidad del fondo
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Alineo el texto en la parte superior
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0), // Espacio en blanco en la parte superior
                  Text(
                    'Puntos Acumulados',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Peso (g)')),
                      DataColumn(label: Text('Puntos')),
                      DataColumn(label: Text('Fecha')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('1000')),
                        DataCell(Text('50')),
                        DataCell(Text('2023-09-19')),
                      ]),
                      // Agregar más filas para otros datos aquí
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
