import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';



class RealTimeBarChart extends StatefulWidget {
     final valuek;
     RealTimeBarChart({super.key, this.valuek,});
  @override
  _RealTimeBarChartState createState() => _RealTimeBarChartState();
}

class _RealTimeBarChartState extends State<RealTimeBarChart> {
  List<double> data = List.filled(7, 0); // Initialize with zeros for 7 days
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }
    LinearGradient get _barsGradient => LinearGradient(
        colors: [
         Color.fromARGB(255, 180, 179, 179),
         Color.fromARGB(255, 180, 189, 179)
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  FlBorderData get borderData => FlBorderData(
        show: false,
      );
      
  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Color.fromRGBO(4, 62, 117, 0.95),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
        FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
  void startTimer() {
    // Simulate real-time data updates every second
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Update data with random values for other days
        for (int i = 0; i < data.length; i++) {
          if (i == DateTime.now().weekday ) {
            // Set today's value to 4 (assuming today is Wednesday)
            data[i] = 5;
          } else {
            // Generate a random value between 0 and 100 for other days
            data[i] = data[i];
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'St';
        break;
      case 1:
        text = 'Sn';
        break;
      case 2:
        text = 'Mn';
        break;
      case 3:
        text = 'Te';
        break;
      case 4:
        text = 'Wed';
        break;
      case 5:
        text = 'Tu';
        break;
      case 6:
        text = 'Fr';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }
  @override
  Widget build(BuildContext context) {
    return 
          
            BarChart(
              BarChartData(
                borderData:borderData,
                barTouchData:barTouchData,
                titlesData:titlesData,
                gridData: FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: data.reduce((value, element) => value > element ? value : element) + 10,
                barGroups: [
                  for (int i = 0; i < data.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          
                          toY: data[i],
                          color: Colors.blue,
                        ),
                        
                      ],
                                                showingTooltipIndicators: [0],

                    ),
                ],
              ),
            );
      
    
  }
}
