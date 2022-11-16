import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:attendance_dbms/mongodb.dart';
import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class AttendaceHome extends StatefulWidget {
  const AttendaceHome({Key? key}) : super(key: key);

  @override
  State<AttendaceHome> createState() => _AttendaceHomeState();
}

class _AttendaceHomeState extends State<AttendaceHome> {
  @override
  List attendanceDeets = [];
  bool submitted = false;
  DateTime selectedDate = DateTime.now();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Container(
                  height: height * 0.5,
                  child: SfCalendar(
                    maxDate: DateTime.now(),
                    showNavigationArrow: true,
                    view: CalendarView.month,

                    // monthCellBuilder:
                    //     (BuildContext buildContext, MonthCellDetails details) {
                    //   return InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         selectedDate = details.date;
                    //         attendanceDeets = [];
                    //       });
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: details.date.isAfter(DateTime.now())
                    //               ? Colors.grey.shade400
                    //               : Colors.transparent,
                    //           border: Border.all(
                    //               color: Colors.grey.shade600,
                    //               width: 0.002 * width)),
                    //       child: Center(
                    //         child: Container(
                    //           padding: const EdgeInsets.all(4),
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: details.date.isSameDate(DateTime.now())
                    //                 ? Colors.blue
                    //                 : Colors.transparent,
                    //           ),
                    //           child: Text(
                    //             details.date.day.toString(),
                    //             style: TextStyle(fontSize: 18),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // },
                    onTap: (CalendarTapDetails x) async {
                      if (x.date == null) {
                        selectedDate = DateTime.now();
                      } else {
                        selectedDate = x.date!;
                      }
                      attendanceDeets = [];
                      var temp = await MongoDatabase.getattendance(
                          DateFormat('dd-MM-yyyy').format(selectedDate));
                      attendanceDeets.length = temp.length;
                    },
                    monthViewSettings: MonthViewSettings(
                      showTrailingAndLeadingDates: false,
                      showAgenda: false,
                      appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                      agendaViewHeight: height * 0.1,
                    ),
                  ),
                ),
              ),
              Text(
                "Students",
                style: TextStyle(fontSize: 23),
              ),
              FutureBuilder<List<Map>>(
                  future: MongoDatabase.getattendance(
                      DateFormat('dd-MM-yyyy').format(selectedDate)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext _, int index) {
                            if (attendanceDeets.length == 0) {
                              attendanceDeets.length = snapshot.data!.length;
                            }
                            if (attendanceDeets[index] == null) {
                              attendanceDeets[index] = {
                                'student': snapshot.data![index]['student'],
                                'attendance': snapshot.data![index]
                                    ['attendance']
                              };
                            }
                            return ListTile(
                              title: Text(snapshot.data![index]['student']),
                              trailing: CupertinoSwitch(
                                  value: attendanceDeets[index]['attendance'],
                                  onChanged: (bool x) {
                                    setState(() {
                                      attendanceDeets[index]['attendance'] = x;
                                    });
                                  }),
                            );
                          });
                    } else
                      return CircularProgressIndicator();
                  }),
              InkWell(
                  onTap: () async {
                    print(attendanceDeets);
                    await MongoDatabase.addattendance(
                        DateFormat('dd-MM-yyyy').format(selectedDate),
                        attendanceDeets);
                    setState(() {
                      submitted = true;
                    });
                  },
                  child: Container(
                      width: 150,
                      height: 100,
                      color: Colors.grey,
                      child: Text("Submit"))),
              submitted ? Text("Uploaded attendance details") : Container()
            ],
          ),
        ),
      ),
    );
  }
}
