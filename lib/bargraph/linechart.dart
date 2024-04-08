import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;



class RealTimeLineChartDemo extends StatefulWidget {
  @override
  _RealTimeLineChartDemoState createState() => _RealTimeLineChartDemoState();
}

class _RealTimeLineChartDemoState extends State<RealTimeLineChartDemo> {
  List<double> _dataPoints = []; // List to store data points
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Method to update data points every hour
  void _updateDataPoints() {
    // Generate random data point
    double newDataPoint = _generateRandomDataPoint();
    setState(() {
      _dataPoints.add(newDataPoint);
      if (_dataPoints.length > 24) {
        _dataPoints.removeAt(0); // Keep only last 24 data points
      }
    });
  }
 
       FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
           
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
  // Method to start the timer for updating data points
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateDataPoints();
    });
  }

  // Generate random data point between 0 and 40
  double _generateRandomDataPoint() {
    return math.Random().nextInt(80)+20 ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users live per day',style: TextStyle(fontSize: 13),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 60,
            minY: 0,
            maxY: 200,
            titlesData:titlesData,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: _dataPoints
                    .asMap()
                    .entries
                    .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                    .toList(),
                isCurved: true,
                color: Color.fromARGB(255, 28, 190, 20),
                barWidth: 2,
                isStrokeCapRound: false,
                
                belowBarData: BarAreaData(show: false),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
