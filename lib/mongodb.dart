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
    print(studentpresent.length);
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

    for (var i = 0; i < studentpresent.length; i++) {
      var student = studentpresent[i]['student'];
      var pre = studentpresent[i]['attendance'];
      await coll.insertOne({
        'student': student,
        'attendance': pre,
        'date': date,
        'teacher': teacher
      });
    }

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

  static addIndivMarks(student, subject, String half, String fin) async {
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
      "half_yearly": double.parse(half),
      "finals": double.parse(fin),
      "subject": subject
    });
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
    var attend = db.collection('Attendance');
    // Fluent way
    var coll = db.collection("Student");
    var data = await coll.find({'teacher': teacher}).toList();
    for (int i = 0; i < data.length; i++) {
      var x = await attend.findOne(
          {'teacher': teacher, 'student': data[i]['student'], 'date': date});
      data[i]['attendance'] = x?['attendance'] ?? false;
    }
    print(data);
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
