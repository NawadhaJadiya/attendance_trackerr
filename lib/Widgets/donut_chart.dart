import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DonutChart extends StatelessWidget {
  const DonutChart(this.attendedClasses, this.missedClasses, {super.key});

  final int attendedClasses;
  final int missedClasses;

  @override
  PieChart build(context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 120,
        sections: [
          PieChartSectionData(
            value: attendedClasses.toDouble(),
            title: ' ',
            color: const Color.fromARGB(255, 53, 0, 110),
            // color: Colors.green,
            radius: 25,
          ),
          PieChartSectionData(
            value: missedClasses.toDouble(),
            title: ' ',
            // color: Colors.red,
            color: Color.fromARGB(51, 53, 0, 110),
            radius: 25,
          ),
        ],
      ),
    );
  }
}
