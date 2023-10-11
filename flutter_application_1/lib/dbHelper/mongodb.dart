import 'dart:developer';
import 'package:flutter_application_1/MongoDBModel.dart';
import 'package:flutter_application_1/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL); //1
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION); //2
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong while inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }


 static Future<List<MongoDbModel>> getUserRecords(String username) async {
  try {
    print('Buscando registros de puntos para el usuario: $username');
    final userDataList = await userCollection
        .find(where.eq("nombres", username))
        .fields(['nombres', 'peso', 'puntos', 'fecha'])
        .toList();

    print('Documentos encontrados: ${userDataList.length}');

    if (userDataList.isNotEmpty) {
      List<MongoDbModel> records = userDataList
          .map((json) => MongoDbModel.fromJson(json))
          .toList();
      return records;
    } else {
      print('No se encontraron registros de puntos para $username');
      return [];
    }
  } catch (e) {
    print('Error al obtener registros de puntos: $e');
    throw e;
  }
}
  
}
