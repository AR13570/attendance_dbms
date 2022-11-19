import 'package:attendance_dbms/attendance.dart';
import 'package:attendance_dbms/grade_home.dart';
import 'package:attendance_dbms/student_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String user;
  const HomePage({Key? key,required this.user}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
        toolbarHeight: 100,
        title: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi,",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  widget.user,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AttendaceHome()));
                      },
                      child: Container(
                          width: 150,
                          height: 100,
                          color: Colors.grey,
                          child: Text("Attendance"))),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GradeHome()));
                      },
                      child: Container(
                          width: 150,
                          height: 100,
                          color: Colors.grey,
                          child: Text("Grades"))),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Students()));
                  },
                  child: Container(
                      width: 300,
                      height: 100,
                      color: Colors.grey,
                      child: Text("Students"))),
            ],
          ),
        ),
      ),
    );
  }
}
