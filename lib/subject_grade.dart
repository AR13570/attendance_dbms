import 'package:flutter/material.dart';

import 'mongodb.dart';

class SubjectGrade extends StatefulWidget {
  String subject;
  SubjectGrade({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectGrade> createState() => _SubjectGradeState();
}

class _SubjectGradeState extends State<SubjectGrade> {
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
              widget.subject,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(
                "Student list",
                style: TextStyle(fontSize: 33),
              ),
              FutureBuilder<List<Map>>(
                  future: MongoDatabase.getmarks(widget.subject),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext _, int index) {
                            return subjectMarksList(
                              index,
                              snapshot.data![index]['student'],
                              widget.subject,
                              snapshot.data![index]['half_yearly'],
                              snapshot.data![index]['finals'],
                            );
                          });
                    } else
                      return CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget subjectMarksList(
    index,
    student,
    sub,
    hy,
    finals,
  ) {
    TextEditingController _hf = TextEditingController(text: hy.toString());
    TextEditingController _fin = TextEditingController(text: finals.toString());
    return ExpansionTile(
      leading: Text((index + 1).toString()),
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
                      width: 100,
                      child: TextFormField(
                        controller: _hf,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black))),
                        keyboardType: TextInputType.number,
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
                      width: 100,
                      child: TextFormField(
                        controller: _fin,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black))),
                        keyboardType: TextInputType.phone,
                      ))
                ],
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  MongoDatabase.addIndivMarks(
                      student, sub, _hf.text, _fin.text);
                  setState(() {});
                },
                child: Text("Submit"))
          ],
        )
      ],
    );
  }
}
