// import 'package:attendance_trackerr/Models/input_schedule.dart';
import 'package:attendance_trackerr/Providers/daily_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTimeTable extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTimeTableState();
}

class _AddTimeTableState extends ConsumerState<AddTimeTable> {
  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(scheduleProvider);
    return SizedBox(
      height: 520,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(7),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Switch(
                      value: schedule.dayStatus[index],
                      onChanged: (value) {
                        setState(() {
                          schedule.updateDayStatus(index, value);
                        });
                      },
                    ),
                    title: Text(
                      schedule.days[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                ),
                TimePickerSpinner(
                  is24HourMode: false,
                  onTimeChange: (value) {
                    setState(() {
                      schedule.updateTime(index, value);
                    });
                  },
                  spacing: 9,
                  normalTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 150, 150, 150), fontSize: 12),
                  highlightedTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 18),
                  isForce2Digits: true,
                  itemHeight: 30,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
