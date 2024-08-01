class ScheduleConstants {
  static List<DateTime> mondayDates = [];
  static List<DateTime> tuesdayDates = [];
  static List<DateTime> wednesdayDates = [];
  static List<DateTime> thursdayDates = [];
  static List<DateTime> fridayDates = [];

  static void initDates() {
    final today = DateTime.now();

    final fiveMonthsFromNow = DateTime(today.year, today.month + 5, today.day);

    for (DateTime datee = today;
        datee.compareTo(fiveMonthsFromNow) <= 0;
        datee = datee.add(Duration(days: 1))) {
      if (datee.weekday == DateTime.monday) {
        mondayDates.add(datee);
      } else if (datee.weekday == DateTime.tuesday) {
        tuesdayDates.add(datee);
      } else if (datee.weekday == DateTime.wednesday) {
        wednesdayDates.add(datee);
      } else if (datee.weekday == DateTime.thursday) {
        thursdayDates.add(datee);
      } else if (datee.weekday == DateTime.friday) {
        fridayDates.add(datee);
      }
    }
  }
}
