import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class Mychart extends StatefulWidget {
  const Mychart({super.key});

  @override
  State<Mychart> createState() => _MychartState();
}

class _MychartState extends State<Mychart> {
          FlTitlesData get titlesData => const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
           
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
        FlBorderData get borderData => FlBorderData(
        show: false,
      );
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        
         body: LineChart(
           LineChartData(
             lineBarsData: [
               LineChartBarData(
                 spots: [
                   FlSpot(0, 1),
                   FlSpot(1, 3),
                   FlSpot(2, 2),
                   FlSpot(3, 4),
                   FlSpot(4, 3),
                   FlSpot(5, 5),
                   FlSpot(6, 4),
                 ],
                 isCurved: true, // Set to true to make the line curved
                 color: Color.fromARGB(255, 16, 181, 21),
                 barWidth: 4,
                 belowBarData: BarAreaData(
                   show: false,
                 ),
               ),
             ],
             borderData: borderData,
             gridData: FlGridData(show: false),
             titlesData:titlesData,
             
             minX: 0,
             maxX: 6,
             minY: 0,
             maxY: 6,
           ),
         ),
       );
    
  }
}