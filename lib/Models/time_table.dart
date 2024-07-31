// import 'package:attendance_trackerr/Models/input_schedule.dart';
import 'package:attendance_trackerr/Models/schedule_constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  int? studentId;
  late List<Subject> subject;

  Schedule({
    required this.subject,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'subject': subject.map((subject) => subject.toMap()).toList(),
    };
  }

  Schedule.fromMapObject(Map<String, dynamic> map) {
    studentId = map['studentId'];

    subject = map['subject']
        .map((subjectMap) => Subject.fromMapObject(subjectMap))
        .toList()
        .cast<Subject>();
  }
}

class Subject {
  late List<Session> session;

  Subject({required this.session});

  Map<String, dynamic> toMap() {
    return {
      'session': session.map((session) => session.toMap()).toList(),
    };
  }

  Subject.fromMapObject(Map<String, dynamic> map) {
    session = map['session']
        .map((sessionMap) => Session.fromMapObject(sessionMap))
        .toList()
        .cast<Session>();
  }
}

class Session {
  late List<DateTime> dates;
  late String startTime;

  Session({required this.dates, required this.startTime});

  factory Session.mondaySession(String startTime) {
    return Session(dates: ScheduleConstants.mondayDates, startTime: startTime);
  }

  factory Session.tuesdaySession(String startTime) {
    return Session(dates: ScheduleConstants.tuesdayDates, startTime: startTime);
  }

  factory Session.wednesdaySession(String startTime) {
    return Session(
        dates: ScheduleConstants.wednesdayDates, startTime: startTime);
  }

  factory Session.thursdaySession(String startTime) {
    return Session(
        dates: ScheduleConstants.thursdayDates, startTime: startTime);
  }

  factory Session.fridaySession(String startTime) {
    return Session(dates: ScheduleConstants.fridayDates, startTime: startTime);
  }

  Map<String, dynamic> toMap() {
    return {
      'dates': dates,
      'start_time': startTime,
    };
  }

  Session.fromMapObject(Map<String, dynamic> map) {
    dates = map['dates'].cast<String>();
    startTime = map['start_time'];
  }
}


/*

make timestamp lists for the time
we will use timestamp while storing the data 



*/
