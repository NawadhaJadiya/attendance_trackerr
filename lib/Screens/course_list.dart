import 'dart:async';
import 'package:attendance_trackerr/Screens/helper.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:attendance_trackerr/Models/attendance_data.dart';
import 'package:attendance_trackerr/Screens/add_course.dart';
import 'package:attendance_trackerr/Screens/enter_attendance.dart';
import 'package:attendance_trackerr/Models/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CourseListState();
  }
}

class _CourseListState extends State<CourseList> {
  final AttendanceDatabaseHelper databaseHelper = AttendanceDatabaseHelper();
  List<AttendanceData> courseNames = [];

  int count = 0;
  late Future<Database> dbFuture;

  @override
  void initState() {
    super.initState();

    dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<AttendanceData>> courseListFuture =
          databaseHelper.getCourseList();
      courseListFuture.then((courseNames) {
        setState(() {
          this.courseNames = courseNames;
          count = courseNames.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 11, 0, 23),
        title: Text(
          'Courses',
          style: GoogleFonts.signikaNegative(
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400)),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 11, 0, 23),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
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
      ),
      body: FutureBuilder<List<AttendanceData>>(
        future: databaseHelper.getCourseList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<AttendanceData>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              // data is empty, display message
              return const Center(
                  child: Text(
                      'Please add a course by clicking on the + icon below',
                      style: TextStyle(color: Colors.white, fontSize: 17)));
            } else {
              // data is not empty, build UI using courseDisplay()
              return courseDisplay();
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 53, 0, 110),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddCourse(
                AttendanceData(currrentCourseName: '', currentStatus: -1),
                _fetchCourseList);
          })).then((value) {
            if (value != null && value == true) {
              // Refresh the state of the CourseList widget if the attendance was recorded successfully
              setState(() {
                _fetchCourseList();
              });
            }
          });
        },
        tooltip: 'add course',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _fetchCourseList() async {
    List<AttendanceData> updatedCourseList =
        await AttendanceDatabaseHelper().getCourseList();
    setState(() {
      courseNames = updatedCourseList;
      count = courseNames.length;
    });
  }

  Future<double> calcPercentage(String course) async {
    int attendedClasses = await databaseHelper.getClasses(course, 1);
    int missedClasses = await databaseHelper.getClasses(course, 0);

    return ((attendedClasses / (attendedClasses + missedClasses)) * 100)
      ..toStringAsFixed(0);
  }

  Widget courseDisplay() {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.width / 1.5),
        children: List.generate(courseNames.length, (index) {
          return Container(
            margin: const EdgeInsets.all(17),
            child: Card(
              color: const Color.fromARGB(255, 53, 0, 110),
              elevation: 2.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Stack(children: [
                      EnterAttendence(
                          courseNames[index].currrentCourseName,
                          AttendanceData(
                            currrentCourseName:
                                courseNames[index].currrentCourseName,
                            currentStatus: 0,
                          ),
                          _fetchCourseList,
                          calcPercentage),
                    ]);
                  }));
                },
                child: Column(children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    courseNames[index].currrentCourseName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.signikaNegative(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                      future:
                          calcPercentage(courseNames[index].currrentCourseName),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const CircularProgressIndicator();
                        }
                        final double percentage = snapshot.data as double;
                        Color? pColor;
                        if (percentage >= 75) {
                          pColor = Colors.green;
                        } else if (percentage < 60) {
                          pColor = Colors.red;
                        } else {
                          pColor = Colors.amber;
                        }

                        return Container(
                          padding: const EdgeInsets.all(
                              8.0), // Adjust padding as needed
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: pColor, // Change border color
                              width: 3.0, // Adjust border width
                            ),
                          ),
                          child: Text(
                            '${percentage.toStringAsFixed(0) == 'NaN' ? 0 : percentage.toStringAsFixed(0)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors
                                    .white), // Center text within the circle
                          ),
                        );
                      }),
                ]),
              ),
            ),
          );
        }));
  }
}
