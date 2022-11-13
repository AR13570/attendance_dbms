import 'package:attendance_dbms/mongodb.dart';
import 'package:flutter/material.dart';

class Students extends StatelessWidget {
  Students({Key? key}) : super(key: key);

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              Text("Student Name"),
                              Expanded(
                                child: TextFormField(
                                  controller: name,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  validator: (val) {},
                                ),
                              ),
                            ],
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                bool state =
                                    await MongoDatabase.addstudent(name.text);
                                if (state == true)
                                  Navigator.pop(context);
                                else
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Student Exist")));
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
          toolbarHeight: 100,
          title: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Attendance",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Text("Students"),
            FutureBuilder<List<Map>>(
                future: MongoDatabase.getstudent(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext _, int index) =>
                            ExpansionTile(
                              title: Text(snapshot.data![index]['student']),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [Text("Test 1"), Text("29")],
                                  ),
                                )
                              ],
                            ));
                  } else
                    return CircularProgressIndicator();
                })
          ]),
        ));
  }
}
