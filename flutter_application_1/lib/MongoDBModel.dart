import 'dart:convert';

MongoDbModel welcomeFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String welcomeToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
    String nombres;
    String email;
    int numeroCelular;
    String contrasena;
    String rol;
    int estado;
    DateTime fechaRegistro;
    DateTime fechaActualizacion;
    int peso; // Agregar el campo "Peso (g)"
    int puntos; // Agregar el campo "Puntos"
    DateTime fecha; // Agregar el campo "Fecha"

    MongoDbModel({
        required this.nombres,
        required this.email,
        required this.numeroCelular,
        required this.contrasena,
        required this.rol,
        required this.estado,
        required this.fechaRegistro,
        required this.fechaActualizacion,
        required this.peso,
        required this.puntos,
        required this.fecha,
    });

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        nombres: json["nombres"],
        email: json["email"],
        numeroCelular: json["numeroCelular"],
        contrasena: json["contrasena"],
        rol: json["rol"],
        estado: json["estado"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
        peso: json["peso"],
        puntos: json["puntos"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "email": email,
        "numeroCelular": numeroCelular,
        "contrasena": contrasena,
        "rol": rol,
        "estado": estado,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "fechaActualizacion": fechaActualizacion.toIso8601String(),
        "peso": peso,
        "puntos": puntos,
        "fecha": fecha.toIso8601String(),
    };
    
}


