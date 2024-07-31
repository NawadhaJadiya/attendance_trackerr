import 'package:flutter/material.dart';
import 'package:attendance_trackerr/Models/attendance_data.dart';
import 'package:attendance_trackerr/Models/database_helper.dart';
import 'package:attendance_trackerr/Screens/helper.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceTable extends StatefulWidget {
  AttendanceTable(this.course, this.setData);
  final String course;
  final Function() setData;
  @override
  _AttendanceTableState createState() => _AttendanceTableState(course, setData);
}

class _AttendanceTableState extends State<AttendanceTable> {
  _AttendanceTableState(this.course, this.setData);

  final String course;
  final Function() setData;
  late AttendanceDatabaseHelper dbHelper;
  List<AttendanceData> attendanceList = [];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    dbHelper = AttendanceDatabaseHelper();
    refreshList();
  }

  void refreshList() async {
    List<AttendanceData> list = await dbHelper.getAttendanceList(course);
    setState(() {
      attendanceList = list;
    });
  }

  text_style(double x) {
    return GoogleFonts.signikaNegative(
        textStyle: TextStyle(color: Colors.white, fontSize: x));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 11, 0, 23),
        title: Text(
          course,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Text(isEditing ? 'Save' : 'Edit'),
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: SingleChildScrollView(
                      child: DataTable(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    columns: [
                      DataColumn(
                        label: Text(
                          'Date',
                          style: text_style(15),
                        ),
                      ),
                      DataColumn(label: Text('Status', style: text_style(15))),
                    ],
                    rows: attendanceList.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(
                              Text(data.currentDate, style: text_style(15))),
                          DataCell(
                            isEditing
                                ? DropdownButtonFormField<int>(
                                    key: Key(data.serial.toString()),
                                    value: data.currentStatus,
                                    onTap: () {
                                      // Open dropdown menu
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        data.currentStatus = value!;
                                        saveDb(data);
                                      });
                                    },
                                    dropdownColor: Colors.black,
                                    items: [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text(
                                          'Attended',
                                          style: text_style(15),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 0,
                                        child: Text('Missed',
                                            style: text_style(15)),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text('No class',
                                            style: text_style(15)),
                                      ),
                                    ],
                                  )
                                : Text(_getStatusText(data.currentStatus),
                                    style: text_style(12)),
                          ),
                        ],
                      );
                    }).toList(),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Attended';
      case 0:
        return 'Missed';
      case 2:
        return 'No class';
      default:
        return 'Unknown';
    }
  }

  void saveDb(AttendanceData attendance) async {
    await dbHelper.updateAttendance(attendance);
    setData();
  }
}
