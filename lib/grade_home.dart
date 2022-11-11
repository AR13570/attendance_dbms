import 'package:attendance_dbms/subject_grade.dart';
import 'package:flutter/material.dart';

class GradeHome extends StatelessWidget {
  const GradeHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subject Name"),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                keyboardType: TextInputType.phone,
                                validator: (val) {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subject Code"),
                            Expanded(
                                child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                              keyboardType: TextInputType.phone,
                              validator: (val) {},
                            )),
                          ],
                        )
                      ],
                    ),
                  ));
        },
      ),
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
