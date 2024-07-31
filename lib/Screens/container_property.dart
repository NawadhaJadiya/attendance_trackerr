import 'package:flutter/material.dart';

class ContainerProperty extends StatelessWidget {
  const ContainerProperty(this.title, this.number, {super.key});

  final String title;
  final int number;
  @override
  Widget build(context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 17),
            ),
            const Text(
              'Classes',
              style: TextStyle(fontSize: 17),
            ),
            Text(
              '$number',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ));
  }
}
