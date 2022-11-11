import 'package:attendance_dbms/subject_grade.dart';
import 'package:flutter/material.dart';

class GradeHome extends StatelessWidget {
  const GradeHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
        toolbarHeight: 80,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Subjects",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Choose subject",
              style: TextStyle(fontSize: 33),
            ),
            ListView(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              children: [
                ListTile(
                  tileColor: Colors.grey,
                  title: Text("Subject1"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SubjectGrade(subject: "Subject1")));
                  },
                ),
                ListTile(
                  tileColor: Colors.grey,
                  title: Text("Subject2"),
                  onTap: () {},
                ),
                ListTile(
                  tileColor: Colors.grey,
                  title: Text("Subject3"),
                  onTap: () {},
                ),
                ListTile(
                  tileColor: Colors.grey,
                  title: Text("Subject4"),
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
