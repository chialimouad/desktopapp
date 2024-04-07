import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class EcgChart extends StatefulWidget {
  @override
  _EcgChartState createState() => _EcgChartState();
}

class _EcgChartState extends State<EcgChart> {
  List<double> hourlyHeartbeatValues = List.filled(24, 0); // Initialize with zeros for 24 hours
  late Timer timer;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    // Simulate real-time data updates every second
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Update heartbeat values for each hour
        for (int i = 0; i < hourlyHeartbeatValues.length; i++) {
          hourlyHeartbeatValues[i] = random.nextDouble() * 100; // Random values between 0 and 100
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        padding: EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  hourlyHeartbeatValues.length,
                  (index) => FlSpot(index.toDouble(), hourlyHeartbeatValues[index]),
                ),
                isCurved: true,
                color: Colors.blue,
                barWidth: 2,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: false),
              ),
            ],
            titlesData: FlTitlesData(
              
              bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              
              
            ),
          ),
              
           
          ),
           borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
        ),
      )),
    );
  }
}
