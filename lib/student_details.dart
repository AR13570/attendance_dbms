import 'package:attendance_dbms/mongodb.dart';
import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  Students({Key? key}) : super(key: key);

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                builder: (BuildContext context) => SafeArea(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
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
                                  "Student Name",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: name,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 4),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                    validator: (val) {},
                                  ),
                                ),
                              ],
                            ),
                            OutlinedButton(
                                onPressed: () async {
                                  bool state =
                                      await MongoDatabase.addstudent(name.text);
                                  if (state == true) {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Student Exist")));
                                  }
                                },
                                child: Text("Submit"))
                          ],
                        ),
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
                "Students",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              FutureBuilder<List<Map>>(
                  future: MongoDatabase.getstudent(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext _, int index) =>
                                ListTile(
                                  leading: Text((index + 1).toString()),
                                  title: Text(snapshot.data![index]['student']),
                                ));
                      } else
                        return Center(
                          child: Text(
                            "No students registered",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        );
                    } else
                      return CircularProgressIndicator();
                  })
            ]),
          ),
        ));
  }
}
