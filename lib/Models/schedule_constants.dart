class ScheduleConstants {
  static List<DateTime> mondayDates = [];
  static List<DateTime> tuesdayDates = [];
  static List<DateTime> wednesdayDates = [];
  static List<DateTime> thursdayDates = [];
  static List<DateTime> fridayDates = [];

  static void initDates() {
    final today = DateTime.now();

    final fiveMonthsFromNow = DateTime(today.year, today.month + 5, today.day);

    for (DateTime date = today;
        date.compareTo(fiveMonthsFromNow) <= 0;
        date = date.add(Duration(days: 1))) {
      if (date.compareTo(DateTime(DateTime.monday)) == 0) {
        mondayDates.add(date);
      } else if (date.compareTo(DateTime(DateTime.tuesday)) == 0) {
        tuesdayDates.add(date);
      } else if (date.compareTo(DateTime(DateTime.wednesday)) == 0) {
        wednesdayDates.add(date);
      } else if (date.compareTo(DateTime(DateTime.thursday)) == 0) {
        thursdayDates.add(date);
      } else if (date.compareTo(DateTime(DateTime.friday)) == 0) {
        fridayDates.add(date);
      }
    }
  }
}
