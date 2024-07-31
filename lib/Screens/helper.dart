import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Helper extends StatelessWidget {
  const Helper();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 0, 23),
        title: Text(
          'Help menu',
          style: GoogleFonts.signikaNegative(
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400)),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/guide1.jpg',
              width: 300,
            ),
            Image.asset(
              'assets/images/guide2.jpg',
              width: 300,
            ),
            Image.asset(
              'assets/images/guide3.jpg',
              width: 300,
            ),
            Image.asset(
              'assets/images/guide4.jpg',
              width: 300,
            ),
            Image.asset(
              'assets/images/guide5.jpg',
              width: 300,
            ),
            Image.asset(
              'assets/images/guide6.jpg',
              width: 300,
            ),
            Image.asset(
              'assets/images/guide7.jpg',
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
