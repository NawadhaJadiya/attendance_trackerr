//import 'package:attendance_trackerr/Screens/course_list.dart';
import 'package:attendance_trackerr/Models/attendance_data.dart';
import 'package:attendance_trackerr/Models/database_helper.dart';
import 'package:attendance_trackerr/Providers/daily_schedule.dart';
// import 'package:attendance_trackerr/Providers/daily_schedule.dart';
import 'package:attendance_trackerr/Widgets/add_timeTable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendance_trackerr/Screens/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:attendance_trackerr/Models/attendance_data.dart';
//import 'package:attendance_trackerr/Models/database_helper.dart';

class AddCourse extends ConsumerStatefulWidget {
  const AddCourse(this.attendance, this.refetchCourseList, {super.key});
  final Function() refetchCourseList;
  final AttendanceData attendance;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddCourseState();
  }
}

class _AddCourseState extends ConsumerState<AddCourse> {
  _AddCourseState();

  AttendanceDatabaseHelper databaseHelper = AttendanceDatabaseHelper();
  final courseNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(scheduleProvider); //declared the provider
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 0, 23),
        title: Text(
          'Add Course',
          style: GoogleFonts.signikaNegative(
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400)),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
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
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(children: [
            //course name field
            Padding(
              padding: const EdgeInsets.all(10),
              child: Theme(
                  data: ThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.white,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: GoogleFonts.signikaNegative(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(0, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: courseNameController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'Course Name',
                      labelStyle: GoogleFonts.signikaNegative(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                  )),
            ),
            AddTimeTable(),

            //save field
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 53, 0, 110),
                      ),
                      child: Text('Save',
                          style: GoogleFonts.signikaNegative(
                            textStyle: const TextStyle(color: Colors.white),
                          )),
                      onPressed: () {
                        // Navigate back to the course list screen
                        schedule.savingDataInFirestore(
                            courseName: courseNameController.text);
                        setState(() {
                          savaToDb();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ])),
    );
  }

  void updateCourseName() {
    widget.attendance.currrentCourseName = courseNameController.text;
  }

  void savaToDb() async {
    if (courseNameController.text.isEmpty ||
        courseNameController.text.trim().isEmpty) {
      _showAlertDialog('Alert', 'Please enter something');
      return;
    }
    if (courseNameController.text.trim().length > 12) {
      _showAlertDialog(
          'Alert', 'The course name must not exceed more than 12 characters');
      return;
    }
    updateCourseName(); // Update the course name
    int result = await databaseHelper.insertAttendance(widget.attendance);
    Navigator.pop(context, result);
    widget.refetchCourseList();
    if (result != 0) {
      _showAlertDialog('Status', 'Course Name added successfully');
    } else {
      _showAlertDialog('Status', 'Problem saving the note');
    }
  }

  void _showAlertDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 53, 0, 110),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
