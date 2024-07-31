import 'package:attendance_trackerr/Models/attendance_data.dart';
import 'package:attendance_trackerr/Screens/donut_text.dart';

import 'package:attendance_trackerr/Screens/tableView.dart';
import 'package:attendance_trackerr/Screens/helper.dart';
import 'package:flutter/material.dart';
import 'package:attendance_trackerr/Widgets/donut_chart.dart';
import 'package:attendance_trackerr/Models/database_helper.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';

class EnterAttendence extends StatefulWidget {
  const EnterAttendence(
      this.course, this.attendance, this.refetchList, this.calcPercentage,
      {super.key});
  final Function() refetchList;
  final Future<double> Function(String) calcPercentage;

  final String course;

  final AttendanceData attendance;
  @override
  State<StatefulWidget> createState() {
    return _EnterAttendanceState(
        course, attendance, refetchList, calcPercentage);
  }
}

class _EnterAttendanceState extends State<EnterAttendence> {
  _EnterAttendanceState(
      this.course, this.attendance, this.refetchList, this.calcPercentage);
  final Function() refetchList;
  final AttendanceData attendance;
  final Future<double> Function(String) calcPercentage;
  final String course;
  late int attendedClasses = 0;
  late int missedClasses = 0;
  double percent = 0;
  int totalClasses = 0;
  int requiredClasses = 0;
  int status = 0;
  AttendanceDatabaseHelper databaseHelper = AttendanceDatabaseHelper();

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() async {
    int dummyAttendedClasses = await databaseHelper.getClasses(course, 1);
    int dummyMissedClasses = await databaseHelper.getClasses(course, 0);

    setState(() {
      attendedClasses = dummyAttendedClasses;
      missedClasses = dummyMissedClasses;
      percent = (attendedClasses * 100) / (attendedClasses + missedClasses);
      totalClasses = attendedClasses + missedClasses;
      requiredClasses = 3 * missedClasses - attendedClasses;
    });
  }

  text_style(double x) {
    return GoogleFonts.signikaNegative(
        textStyle: TextStyle(color: Colors.white, fontSize: x));
  }

  belowDonut(String classes, int num) {
    return Container(
        height: 70,
        width: 170,
        margin: const EdgeInsets.all(10), // Adjust margin as needed
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 53, 0, 110),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(children: [
          Text(
            classes,
            style: text_style(18),
          ),
          Text('${num < 0 ? 0 : num}', style: text_style(25))
        ]));
  }

  Widget classButton(int s, int classes, String classStatus, Color c) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: c,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(left: 50, right: 50)),
      onPressed: () {
        setState(() {
          status = s;
          saveToDb();
          setData();
          classes++;
        });
      },
      child: Text(
        classStatus,
        style: text_style(17),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.help_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Helper();
                  }));
                })
          ],
          title: Text(course,
              style: GoogleFonts.signikaNegative(
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
          backgroundColor: const Color.fromARGB(255, 11, 0, 23),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  calcPercentage(course);
                  refetchList();
                });
                Navigator.pop(context);
              })),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 120,
            ),
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  DonutChart(attendedClasses, missedClasses),
                  CenteredText(
                    text:
                        '${percent.toStringAsFixed(0) == 'NaN' ? 0 : percent.toStringAsFixed(0)}%',
                  ) // Pass calculated percentage
                ],
              ),
            ),
            const SizedBox(
              height: 110,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // This centers the boxes horizontally
                children: [
                  belowDonut('Attended Classes', attendedClasses),
                  belowDonut('Required Classes', requiredClasses)
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 53, 0, 110),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(10),
                height: 120,
                width: 365,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          classButton(
                              1, attendedClasses, 'Attended', Colors.green),
                          classButton(
                              0, missedClasses, '  Missed  ', Colors.red)
                        ],
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 11, 0, 23),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              maximumSize: const Size(200, 150),
                              minimumSize: const Size(150, 100)),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AttendanceTable(course, setData);
                            }));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View',
                                style: text_style(15),
                              ),
                              Text(
                                'Details',
                                style: text_style(15),
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 53, 0, 110),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 53, 0, 110),
                        title: Text('Delete Course', style: text_style(18)),
                        content: Text(
                            'The course and all its content will be deleted.',
                            style: text_style(16)),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK', style: text_style(13)),
                            onPressed: () {
                              setState(() {
                                deleteCourse(course);
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Cancel', style: text_style(13)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Delete', style: text_style(15))),
          ],
        ),
      ),
    );
  }

  void updateAttendance() {
    attendance.currentStatus = status;
  }

  void saveToDb() async {
    updateAttendance(); // Update the attendance status
    calcPercentage(course);
    refetchList();
    int result = await databaseHelper.insertAttendance(attendance);

    if (result != 0) {
      _showAlertDialog(
        'Status',
        'Attendance recorded successfully',
      );
      // Pass true as a result indicating successful recording
    } else {
      _showAlertDialog(
        'Status',
        'Try adding the attendance again',
      );
      // Pass false as a result indicating unsuccessful recording
    }
  }

  void _showAlertDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title, style: text_style(12)),
      content: Text(msg, style: text_style(12)),
      backgroundColor: const Color.fromARGB(255, 53, 0, 110),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  void deleteCourse(String course) async {
    int result = await databaseHelper.deleteCourse(attendance);
    refetchList();
    Navigator.pop(context);

    if (result != 0) {
      _showAlertDialog('Status', 'Course and its data deleted ');
      // Pass true as a result indicating successful recording
    } else {
      _showAlertDialog('Status', 'Try again');
      // Pass false as a result indicating unsuccessful recording
    }
  }
}
