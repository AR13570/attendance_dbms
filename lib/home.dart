import 'package:attendance_dbms/attendance.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
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
                  "User",
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AttendaceHome()));
                  },
                  child: Text("Attendance")),
              ElevatedButton(onPressed: () {}, child: Text("Grades")),
              ElevatedButton(onPressed: () {}, child: Text("Students"))
            ],
          ),
        ),
      ),
    );
  }
}
