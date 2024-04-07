import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class LineChartScreen extends StatefulWidget {
  @override
  _LineChartScreenState createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  late StreamController<List<FlSpot>> _streamController;
  late Timer timer;
  bool isMaximized = false;
  double initialChartHeight = 300.0;
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
  void initState() {
    super.initState();
    _streamController = StreamController<List<FlSpot>>();
    // Start hourly data updates
    timer = Timer.periodic(Duration(hours: 1), (timer) {
      _generateData();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _streamController.close();
    super.dispose();
  }

  // Generate new data for the current hour
  void _generateData() {
    List<FlSpot> newData = [];
    Random random = Random();
    // Generate random data for the current hour
    for (int minute = 0; minute < 60; minute++) {
      double value = 44; // Random value between 0 and 100
      newData.add(FlSpot(minute.toDouble(), value));
    }
    _streamController.sink.add(newData);
  }

  // Toggle chart size between maximized and minimized
  void _toggleChartSize(double delta) {
    setState(() {
      isMaximized = !isMaximized;
      initialChartHeight += delta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            initialChartHeight = MediaQuery.of(context).size.height;
          },
        
          child: StreamBuilder<List<FlSpot>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: isMaximized ? MediaQuery.of(context).size.height : initialChartHeight,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Color.fromARGB(255, 7, 125, 7),
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                      minY: 0,
                      maxY: 100, // Adjust max Y value according to your data
                      gridData: FlGridData(show: false),
                      titlesData: titlesData,
                      borderData: borderData
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );
    
  }
}
