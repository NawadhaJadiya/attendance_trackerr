import 'package:intl/intl.dart';

class AttendanceData {
  int? serial;
  late String currrentCourseName;
  late String currentDate;
  late int currentStatus;

  AttendanceData(
      {required this.currrentCourseName, required this.currentStatus}) {
    final today = DateTime.now();
    currentDate = (DateFormat('dd/MM/yy').format(today)).toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'course_name': currrentCourseName,
      'date': currentDate,
      'status': currentStatus,
    };
  }

  AttendanceData.fromMapObject(Map<String, dynamic> map) {
    serial = map['serial'];
    currrentCourseName = map['course_name'];
    currentDate = map['date'];
    currentStatus = map['status'];
  }
}

  // int? get serial => _serial;

  // String get currrentCourseName => courseName_;

  // String get currentDate => date;

  // int get currentStatus => status;

  // set courseName(String newCourseName) {
  //   if (newCourseName.length >= 225) {
  //     courseName_ = newCourseName;
  //   }
  // }

  // set currentDate(String newDate) {
  //   date = newDate;
  // }

  // set currentStatus(int newStatus) {
  //   if (newStatus == 1 && newStatus == 0) {
  //     status = newStatus;
  //   }
  // }

  // Map<String, dynamic> intoMap() {
  //   var map = Map<String, dynamic>();

  //   map['serial'] = serial;

  //   map['course_name'] = currrentCourseName;
  //   map['date'] = currentDate;
  //   map['status'] = currentStatus;
  //   return map;
  // }

  