import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static Future<bool> loginpage(user,pass) async {
    var db = await Db.create("mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Teacher');
    // Fluent way
    var data = await coll.find(where.eq('user', user)).toList();
    if(data.isEmpty)
      {
        await coll.insertOne({
          'user': user,
          'pass': pass
        });
        return true;
      }
    else if(data[0]['pass'] != pass){
      return false;
    }else{
      return true;
    }
  }
}
