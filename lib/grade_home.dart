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
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              context: context,
              builder: (BuildContext context) => Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Enter details",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subject Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: subject,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 4),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  keyboardType: TextInputType.text,
                                  validator: (val) {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subject Code",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                maxLines: 1,
                                controller: subjectcode,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 4),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                keyboardType: TextInputType.text,
                                validator: (val) {},
                              ),
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
        title: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Subjects",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Choose subject",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<Map>>(
                  future: MongoDatabase.getsubjects(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext _, int index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SubjectGrade(
                                                subject: snapshot.data![index]
                                                    ['subject'])));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: 150,
                                  height: 70,
                                  child: Center(
                                      child: Text(
                                    snapshot.data![index]['subject'],
                                    style: TextStyle(fontSize: 20),
                                  )))),
                          // ListTile(
                          //
                          //   title: Text(snapshot.data![index]['subject']),
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (BuildContext context) =>
                          //                 SubjectGrade(
                          //                     subject: snapshot.data![index]
                          //                         ['subject'])));
                          //   },
                          // ),
                        ),
                      );
                    } else
                      return CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
