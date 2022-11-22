import 'package:attendance_dbms/attendance.dart';
import 'package:attendance_dbms/grade_home.dart';
import 'package:attendance_dbms/student_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String user;
  const HomePage({Key? key, required this.user}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  logout() async {
    final SharedPreferences prefs = await _prefs;
    bool check = prefs.getBool('check') ?? false;
    prefs.setBool('check', false);
      Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
        toolbarHeight: 90,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi,",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    Text(
                      widget.user,
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          width: 150,
                          height: 100,
                          child: Center(
                              child: Text(
                            "Attendance",
                            style: TextStyle(fontSize: 20),
                          )))),
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
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          width: 150,
                          height: 100,
                          child: Center(
                              child: Text(
                            "Grades",
                            style: TextStyle(fontSize: 20),
                          )))),
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      width: 150,
                      height: 100,
                      child: Center(
                        child: Text(
                          "Students",
                          style: TextStyle(fontSize: 20),
                        ),
                      ))),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    logout();
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.redAccent,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      width: 150,
                      height: 100,
                      child: Center(
                        child: Text(
                          "Log Out",
                          style: TextStyle(fontSize: 20),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
