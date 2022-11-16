import 'package:flutter/material.dart';

import 'mongodb.dart';

class SubjectGrade extends StatelessWidget {
  String subject;
  SubjectGrade({Key? key, required this.subject}) : super(key: key);

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
          children: [
            Text(
              subject,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Student list",
              style: TextStyle(fontSize: 33),
            ),
            FutureBuilder<List<Map>>(
                future: MongoDatabase.getmarks(subject),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext _, int index) =>
                            subjectMarksList(snapshot.data![index]['student'],snapshot.data![index]['half_yearly'],snapshot.data![index]['finals']));
                  } else
                    return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }

  ExpansionTile subjectMarksList(student,hy,finals) {
    return ExpansionTile(
                title: Text(student),
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Half Yearly"),
                            Container(
                                width: 40,
                                child: TextFormField(
                                  initialValue: hy.toString(),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {},
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Finals"),
                            Container(
                                width: 40,
                                child: TextFormField(
                                  initialValue: finals.toString(),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black))),
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {},
                                ))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
  }
}
