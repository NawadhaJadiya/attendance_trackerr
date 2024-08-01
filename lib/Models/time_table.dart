// import 'package:attendance_trackerr/Models/input_schedule.dart';

import 'package:attendance_trackerr/Models/schedule_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  late String studentId;
  late List<Subject> subject;

  Schedule({
    required this.subject,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'subject': subject.map((subject) => subject.toMapa()).toList(),
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
  //old late List<Session> session;
  late List<Timestamp> tsp; //new

  Subject({required this.tsp});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'session': session.map((session) => session.toMap()).toList(),
  //   };
  // }

  // new code

  Map<String, List<Timestamp>> toMapa() {
    return {'timeStamp': tsp};
  }

  Subject.fromMapObject(Map<String, dynamic> map) {
    tsp = map['timeStamp'].cast<Timestamp>();
  }
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

//   Map<String, dynamic> toMap() {
//     return {
//       'dates': dates,
//       'start_time': startTime,
//     };
//   }

//   Session.fromMapObject(Map<String, dynamic> map) {
//     dates = map['dates'].cast<String>();
//     startTime = map['start_time'];
//   }
// }

/*

make timestamp lists for the time
we will use timestamp while storing the data 



*/
