import 'package:flutter/material.dart';

class Students extends StatelessWidget {
  const Students({Key? key}) : super(key: key);

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
                              onPressed: () {}, child: Text("Submit"))
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
            ListView(
              shrinkWrap: true,
              children: [
                ExpansionTile(
                  title: Text("student1"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Test 1"), Text("29")],
                      ),
                    )
                  ],
                )
              ],
            )
          ]),
        ));
  }
}
