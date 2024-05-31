import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
class status extends ChangeNotifier {
  late bool averageBPM = false;
  late int indx = 0;

  redgreen(bool iscon)  {
     averageBPM = iscon;
     print(averageBPM);
     if (averageBPM==false) {
            return indx=1;

     }
     return 0;
   
  }
  

 


}







class RealTimeLineChartDemo extends StatefulWidget {
  @override
  _RealTimeLineChartDemoState createState() => _RealTimeLineChartDemoState();
}

class _RealTimeLineChartDemoState extends State<RealTimeLineChartDemo> {
  List<double> _dataPoints = []; // List to store data points
  Timer? _timer;
void _updateChartData(List<double> dataPoints) {
  setState(() {
    _dataPoints = dataPoints;
  });
}

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

  

  void _updateDataPoints(int ind) {
    // Generate random data point
    int newDataPoint = ind; // Add ind to the data point
    setState(() {
      _dataPoints.add(newDataPoint.toDouble());
      if (_dataPoints.length > 24) {
        _dataPoints.removeAt(0); // Keep only last 24 data points
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final statusProvider = Provider.of<status>(context, listen: false);
      await statusProvider.redgreen(true);
      int ind = statusProvider.indx;
      _updateDataPoints(ind);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users live per day',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 24,
            minY: 0,
            maxY: 200,
            titlesData: titlesData,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: _dataPoints
                    .asMap()
                    .entries
                    .map((entry) =>
                        FlSpot(entry.key.toDouble(), entry.value))
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
