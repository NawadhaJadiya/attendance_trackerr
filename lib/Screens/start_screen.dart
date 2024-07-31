import 'package:attendance_trackerr/tracker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/icon1.png',
          width: 200,
        ),
        const SizedBox(height: 20),
        Text('Abhyudaya',
            style: GoogleFonts.signikaNegative(
              textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            )),
        const SizedBox(height: 26),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 53, 0, 110),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const
                    // Main content (Tracker widget)
                    Tracker();
                // Sticky footer
              }));
            },
            child: Text('Get Started',
                style: GoogleFonts.signikaNegative(
                  textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                ))),
      ],
    ));
  }
}
