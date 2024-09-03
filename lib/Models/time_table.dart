// import 'package:attendance_trackerr/Models/input_schedule.dart';

import 'package:attendance_trackerr/Models/schedule_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
class Schedule {
  late List<Subject> subject;
  final String studentId = const Uuid().v4();

  Schedule({required this.subject});

  Map<String, dynamic> toMap() {
    return {
      'subject': subject.map((subject) => subject.toMapa()).toList(),
    };
  }

  Schedule.fromMapObject(Map<String, dynamic> map) {
    subject = (map['subject'] as List)
        .map((subjectMap) => Subject.fromMapObject(subjectMap))
        .toList();
  }
}

class Subject {
  final String name;
  late List<Timestamp> tsp;

  Subject({required this.name, required this.tsp});

  Map<String, dynamic> toMapa() {
    return {name: tsp};
  }

  Subject.fromMapObject(Map<String, dynamic> map)
      : name = map.keys.first,
        tsp = List<Timestamp>.from(map.values.first);
}

class Session {
  late List<Timestamp> timeStamps;
  late List<DateTime> dates;
  late String startTime;

  Session({required dates});

  factory Session.mondaySession() {
    return Session(dates: ScheduleConstants.mondayDates);
  }

  factory Session.tuesdaySession() {
    return Session(dates: ScheduleConstants.tuesdayDates);
  }

  factory Session.wednesdaySession() {
    return Session(dates: ScheduleConstants.wednesdayDates);
  }

  factory Session.thursdaySession() {
    return Session(dates: ScheduleConstants.thursdayDates);
  }

  factory Session.fridaySession() {
    return Session(dates: ScheduleConstants.fridayDates);
  }

  List<Timestamp> weekTimeStamps(String start, List<DateTime> weekDates) {
    List<Timestamp> wts = [];

    for (int i = 0; i < weekDates.length; i++) {
      var year = weekDates[i].year;
      var month = weekDates[i].month;
      var day = weekDates[i].day;
      var hour = start.substring(0, 2);
      var minute = start.substring(3);
      DateTime specificDate =
          DateTime(year, month, day, int.parse(hour), int.parse(minute));

      wts.add(Timestamp.fromDate(specificDate));
    }
    return wts;
  }
}
