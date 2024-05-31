import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HeartRateChart1 extends StatefulWidget {
  @override
  _HeartRateChart1State createState() => _HeartRateChart1State();
}

class _HeartRateChart1State extends State<HeartRateChart1> {
  List<FlSpot> spots = [];
  List<double> heartRateValues = [];
 bool isRegularRhythm = true;
  // Stream controller for receiving heart rate data
  StreamController<double> heartRateStreamController = StreamController<double>();

  // Timer for adding mock heart rate data (for demonstration)
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Start adding mock heart rate data every second (for demonstration)
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Generate a random heart rate value (for demonstration)
      double heartRate = 60 + (40 * (1 - 2 * (0.5 - Random().nextDouble()))); // Generates a random heart rate between 40 and 100
      // Add the heart rate value to the list
      addHeartRateData(heartRate);
    });

    // Start listening to the heart rate stream
    heartRateStreamController.stream.listen((heartRate) {
      addHeartRateData(heartRate);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    heartRateStreamController.close();
    super.dispose();
  }

  // Method to add heart rate data to the chart
  void addHeartRateData(double heartRate) {
    setState(() {
      heartRateValues.add(heartRate);
      spots.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), heartRate));
      
      // Check for atrial fibrillation
      bool isAFib = detectAtrialFibrillation(heartRateValues);
      if (isAFib) {
        // Handle AFib detection, such as displaying an alert
        print('Atrial fibrillation detected!');
      }
    });
  }

  // Method to detect atrial fibrillation
// Method to detect atrial fibrillation
bool detectAtrialFibrillation(List<double> heartRates) {
  if (heartRates.length < 3) {
    // Not enough data points for detection
    return false;
  }

  // Check heart rate variability
  double thresholdVariability = 10.0; // Adjust as needed
  double sdnn = calculateSDNN(heartRates);
  if (sdnn > thresholdVariability) {
    // High heart rate variability, potential indicator of AFib
    return true;
  }

  // Check rhythm irregularity
  bool isIrregularRhythm = isRhythmIrregular(heartRates);
  if (isIrregularRhythm) {
    // Irregular rhythm, potential indicator of AFib
    return true;
  }

  // No evidence of AFib
  return false;
}

// Method to calculate SDNN (standard deviation of normal-to-normal intervals)
double calculateSDNN(List<double> heartRates) {
  double mean = heartRates.reduce((a, b) => a + b) / heartRates.length;
  double variance = heartRates.map((x) => (x - mean) * (x - mean)).reduce((a, b) => a + b) / heartRates.length;
  return sqrt(variance); // Using sqrt function from dart:math
}
// Method to check if rhythm is irregular
bool isRhythmIrregular(List<double> heartRates) {
  List<double> differences = [];
  for (int i = 1; i < heartRates.length; i++) {
    differences.add((heartRates[i] - heartRates[i - 1]).abs());
  }

  double thresholdDifference = 10.0; // Adjust as needed
  bool isIrregular = differences.any((difference) => difference > thresholdDifference);
  return isIrregular;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                       rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              isRegularRhythm ? 'Regular Rhythm' : 'Irregular Rhythm',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: isRegularRhythm ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
