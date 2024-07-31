import 'package:attendance_trackerr/Screens/course_list.dart';

// import 'package:attendance_trackerr/Screens/tableView.dart';

import 'package:flutter/material.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TrackerState();
  }
}

class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const CourseList(),
      Positioned(
        left: 0,
        bottom: 0,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: const Color.fromARGB(255, 11, 0, 23),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Abhyudaya Elite',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
