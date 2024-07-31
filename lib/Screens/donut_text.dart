import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String text;

  const CenteredText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 60, fontWeight: FontWeight.w200, color: Colors.white),
      ),
    );
  }
}
