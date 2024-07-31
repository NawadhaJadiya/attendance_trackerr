// import 'package:cloud_firestore/cloud_firestore.dart';

class InputSchedule {
  List<bool> dayStatus = List.filled(5, false);
  List<DateTime> time = List.filled(5, DateTime.now());
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  void updateDayStatus(int index, bool status) {
    dayStatus[index] = status;
    print(dayStatus);
    print(time);
  }

  void updateTime(int index, DateTime newTime) {
    time[index] = newTime;
  }

  void savingDataInFirestore() {}
}
