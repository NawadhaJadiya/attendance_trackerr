import 'package:attendance_trackerr/Models/input_schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleProvider = Provider((ref) {
  return InputSchedule();
});
