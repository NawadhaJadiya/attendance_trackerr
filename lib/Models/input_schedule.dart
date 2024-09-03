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

  void savingDataInFirestore(
      {required String courseName, required String? fcm}) async {
    ScheduleConstants.initDates();

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
    final subject = Subject(name: courseName, tsp: allTimeStamps);

    DocumentSnapshot scheduleDoc =
        await FirebaseFirestore.instance.collection('Schedules').doc(fcm).get();

    //Check if the document exists
    if (scheduleDoc.exists) {
      // Get the current list of subjects

      // Update the schedule document with the updated list of subjects
      await FirebaseFirestore.instance.collection('Schedules').doc(fcm).update({
        'subject': FieldValue.arrayUnion([subject.toMapa()]),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Schedules')
          .doc(fcm)
          .set(Schedule(subject: [subject]).toMap());
    }
  }
}

// media query in enter attendamce pg
