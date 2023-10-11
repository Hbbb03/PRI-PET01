import 'dart:developer';
import 'package:app_pruebas/MongoDBModel.dart';
import 'package:app_pruebas/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL); //1
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION); //2
  }

  static Future<MongoDbModel?> getUserByEmail(String email) async {
  try {
    final query = where.eq("email", email); // Consulta para buscar por correo electrónico

    final result = await userCollection.findOne(query);

    if (result != null) {
      return MongoDbModel.fromJson(result);
    } else {
      return null; // Usuario no encontrado
    }
  } catch (e) {
    print(e.toString());
    return null; // Error al buscar el usuario
  }
}

  static Future<List<MongoDbModel>> getAllUsers() async {
  try {
    final result = await userCollection.find().toList();

    // Imprime todos los datos de la colección en la consola
    print('Datos de la colección:');
    for (var data in result) {
      print(data);
    }

    return result.map((data) => MongoDbModel.fromJson(data)).toList();
  } catch (e) {
    print('Error al obtener todos los usuarios: $e');
    return [];
  }
}


}
