import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{
  static connect() async{
    var db = await Db.create("mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
  }
}