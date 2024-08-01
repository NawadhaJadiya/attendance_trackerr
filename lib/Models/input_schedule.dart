// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:attendance_trackerr/Models/schedule_constants.dart';
import 'package:attendance_trackerr/Models/time_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InputSchedule {
  List<bool> dayStatus = List.filled(5, false);
  List<String> time = List.filled(5, DateTime.now().toString());
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  void updateDayStatus(int index, bool status) {
    dayStatus[index] = status;
    print(dayStatus);
    print(time);
  }

  void updateTime(int index, String newTime) {
    time[index] = newTime;
  }

  getToken(String token) {
    return token;
  }

  void savingDataInFirestore({required String courseName}) {
    ScheduleConstants.initDates();
    final firestore = FirebaseFirestore.instance;

    try {
      List<Timestamp> allTimeStamps = [];
      if (dayStatus[0]) {
        allTimeStamps.addAll(Session.mondaySession()
            .weekTimeStamps(time[0], ScheduleConstants.mondayDates));
      }
      if (dayStatus[1]) {
        allTimeStamps.addAll(Session.tuesdaySession()
            .weekTimeStamps(time[1], ScheduleConstants.tuesdayDates));
      }
      if (dayStatus[2]) {
        allTimeStamps.addAll(Session.wednesdaySession()
            .weekTimeStamps(time[2], ScheduleConstants.wednesdayDates));
      }
      if (dayStatus[3]) {
        allTimeStamps.addAll(Session.thursdaySession()
            .weekTimeStamps(time[3], ScheduleConstants.thursdayDates));
      }
      if (dayStatus[4]) {
        allTimeStamps.addAll(Session.fridaySession()
            .weekTimeStamps(time[4], ScheduleConstants.fridayDates));
      }
      // final scheduleRef = firestore.collection('Schedules').add(Schedule)

      // final sub = Subject(tsp: allTimeStamps);
      // final scheduleRef = firestore
      //     .collection('Schedules')
      //     .add(Schedule(subject: [sub]).toMap());
    } catch (e) {
      print(e);
    }
  }
}
