import 'package:attendance_dbms/subject_grade.dart';
import 'package:flutter/material.dart';

import 'mongodb.dart';

class GradeHome extends StatefulWidget {
  GradeHome({Key? key}) : super(key: key);

  @override
  State<GradeHome> createState() => _GradeHomeState();
}

class _GradeHomeState extends State<GradeHome> {
  TextEditingController subject = TextEditingController();

  TextEditingController subjectcode = TextEditingController();

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
                                controller: subject,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                keyboardType: TextInputType.text,
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
                              controller: subjectcode,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                              keyboardType: TextInputType.text,
                              validator: (val) {},
                            )),
                          ],
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              bool state = await MongoDatabase.addsubject(
                                  subject.text, subjectcode.text);
                              if (state == true)
                                setState(() {
                                  Navigator.pop(context);
                                });
                              else
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Subject Exist")));
                            },
                            child: Text("Submit"))
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
            FutureBuilder<List<Map>>(
                future: MongoDatabase.getsubjects(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext _, int index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.grey,
                          title: Text(snapshot.data![index]['subject']),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SubjectGrade(
                                            subject: snapshot.data![index]
                                                ['subject'])));
                          },
                        ),
                      ),
                    );
                  } else
                    return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
