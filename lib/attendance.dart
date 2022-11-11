import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class AttendaceHome extends StatelessWidget {
  const AttendaceHome({Key? key}) : super(key: key);

  @override
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
            CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: height * 0.7,
                  child: SfCalendar(
                    showNavigationArrow: true,
                    view: CalendarView.month,
                    // monthCellBuilder:
                    //     (BuildContext buildContext, MonthCellDetails details) {
                    //   return Container(
                    //     decoration: BoxDecoration(
                    //         border: Border.all(
                    //             color: Colors.grey.shade600, width: 0.002 * width)),
                    //     child: Center(
                    //       child: Container(
                    //         padding: const EdgeInsets.all(4),
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: details.date.isSameDate(DateTime.now())
                    //               ? Colors.blue
                    //               : Colors.transparent,
                    //         ),
                    //         child: Text(
                    //           details.date.day.toString(),
                    //           style: TextStyle(fontSize: 18),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // },
                    monthViewSettings: MonthViewSettings(
                        showTrailingAndLeadingDates: false,
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.none),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
