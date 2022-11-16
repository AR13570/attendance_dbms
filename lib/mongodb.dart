import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  // var db = await Db.create("mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");

  //Login
  static Future<bool> loginpage(user, pass) async {
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Teacher');
    // Fluent way
    var data = await coll.find(where.eq('user', user)).toList();
    if (data.isEmpty) {
      await coll.insertOne({'user': user, 'pass': pass});
      return true;
    } else if (data[0]['pass'] != pass) {
      return false;
    } else {
      return true;
    }
  }

  //Add Subjects in DB
  static Future<bool> addsubject(subject, subjectcode) async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Subject');
    // Fluent way
    var data =
        await coll.find({'subject': subject, 'teacher': teacher}).toList();
    if (data.isEmpty) {
      await coll.insertOne({
        'subject': subject,
        'subject_code': subjectcode,
        'teacher': teacher
      });
      return true;
    } else {
      return false;
    }
  }

  //Add Students into DB
  static Future<bool> addstudent(student) async {
    String teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Student');
    // Fluent way
    var data =
        await coll.find({'student': student, 'teacher': teacher}).toList();
    if (data.isEmpty) {
      await coll.insertOne({'student': student, 'teacher': teacher});
      return true;
    } else {
      return false;
    }
  }

  //Add Attendance into DB
  static Future<bool> addattendance(date, studentpresent) async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Attendance');
    //Add date and teacher into studentpresent list
    for (int i = 0; i < studentpresent.length; i++) {
      studentpresent[i]['date'] = date;
      studentpresent[i]['teacher'] = teacher;
    }
    // Fluent way
    var data = await coll.find({'date': date, 'teacher': teacher}).toList();
    if (!data.isEmpty) {
      await coll.deleteMany({'date': date, 'teacher': teacher});
    }
    await coll.insertMany(studentpresent);
    return true;
  }

  //Add Marks into DB
  static Future<bool> addmarks(exam, studentmarks) async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Scores');
    //Add date and teacher into studentmarks list
    for (int i = 0; i < studentmarks.length; i++) {
      studentmarks[i]['exam'] = exam;
      studentmarks[i]['teacher'] = teacher;
    }
    // Fluent way
    var data = await coll.find({'exam': exam, 'teacher': teacher}).toList();
    if (!data.isEmpty) {
      await coll.deleteMany({'exam': exam, 'teacher': teacher});
    }
    await coll.insertMany(studentmarks);
    return true;
  }

  static Future<bool> addIndivMarks(student, subject, half, fin) async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Scores');
    var data = await coll.find(
        {'subject': subject, 'teacher': teacher, 'student': student}).toList();
    if (!data.isEmpty) {
      await coll.deleteMany(
          {'subject': subject, 'teacher': teacher, 'student': student});
    }
    await coll.insertOne({
      "teacher": teacher,
      "student": student,
      "half_yearly": half,
      "finals": fin,
      "subject": subject
    });
    return true;
  }

  //Get Student List from DB
  static Future<List<Map<String, dynamic>>> getstudent() async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Student');
    // Fluent way
    var data = await coll.find({'teacher': teacher}).toList();
    return data;
  }

  //Get Marks List from DB
  static Future<List<Map<String, dynamic>>> getmarks(subject) async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var score = db.collection('Scores');
    // Fluent way

    var coll = db.collection("Student");
    var data = await coll.find({'teacher': teacher}).toList();
    for (int i = 0; i < data.length; i++) {
      var x = await score.findOne({
        'teacher': teacher,
        'subject': subject,
        'student': data[i]['student']
      });
      data[i]['half_yearly'] = x?['half_yearly'] ?? 0;
      data[i]['finals'] = x?['finals'] ?? 0;
    }
    print(data);
    return data;
  }

  //Get Subject List from DB
  static Future<List<Map<String, dynamic>>> getsubjects() async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Subject');
    // Fluent way
    var data = await coll.find({'teacher': teacher}).toList();
    return data;
  }

  //Get Attendance List from DB
  static Future<List<Map<String, dynamic>>> getattendance(date) async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    var coll = db.collection('Attendance');
    // Fluent way
    var data = await coll.find({'teacher': teacher, 'date': date}).toList();
    if (data.length == 0) {
      coll = db.collection("Student");
      data = await coll.find({'teacher': teacher}).toList();
      for (int i = 0; i < data.length; i++) {
        data[i]['attendance'] = false;
        //data[i]['date'] = date;
      }
    }

    return data;
  }

  //Get Detail of individual Student's Attendance and Marks information
  static Future<List<Map<String, dynamic>>> getstudentperformance(
      student) async {
    var teacher = "Teacher";
    var db = await Db.create(
        "mongodb+srv://dbms:dbms@cluster0.txlqt8w.mongodb.net/School?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    //Get Attendance
    var coll1 = db.collection('Attendance');
    var data1 = await coll1.find({'teacher': teacher}).toList();
    //Get Marks
    var coll2 = db.collection('Scores');
    var data2 = await coll2.find({'teacher': teacher}).toList();
    //Return
    return [
      {"Attendance": data1, "Scores": data2}
    ];
  }
}
