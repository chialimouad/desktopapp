import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class HeartRateCalculator {
  late List<DateTime> _heartbeats;

  HeartRateCalculator() {
    _heartbeats = [];
  }

  void addHeartbeat() {
    _heartbeats.add(DateTime.now());
  }

  double calculateHeartRate() {
    if (_heartbeats.length < 2) {
      return 0.0; // Not enough data to calculate heart rate
    }

    // Calculate time difference between consecutive heartbeats
    List<int> beatDifferences = [];
    for (int i = 1; i < _heartbeats.length; i++) {
      int difference = _heartbeats[i].difference(_heartbeats[i - 1]).inMilliseconds;
      beatDifferences.add(difference);
    }

    // Calculate average time between heartbeats
    double averageDifference = beatDifferences.reduce((a, b) => a + b) / beatDifferences.length;

    // Convert average time difference to beats per minute (BPM)
    double heartRate = 60000 / averageDifference;

    return heartRate;
  }
}

class HeartRateMonitor extends StatefulWidget {
  final valuebpm;
  const HeartRateMonitor({required this.valuebpm, Key? key}) : super(key: key);

  @override
  _HeartRateMonitorState createState() => _HeartRateMonitorState();
}

class _HeartRateMonitorState extends State<HeartRateMonitor> {
  late HeartRateCalculator _heartRateCalculator;
  late Timer _heartRateTimer;
  late List<FlSpot> _heartRateData;
  bool _isRegular = true;
  bool _isFibrillationDetected = false;

  @override
  void initState() {
    super.initState();
    _heartRateCalculator = HeartRateCalculator();
    _heartRateData = [];
    _startHeartRateSimulation();
  }

  void _startHeartRateSimulation() {
    int beatsPerMinute = widget.valuebpm; // Beats per minute
    int millisecondsPerBeat = (60000 ~/ beatsPerMinute);
    _heartRateTimer = Timer.periodic(Duration(milliseconds: millisecondsPerBeat), (timer) {
      setState(() {
        
        // Simulate heart rate
        _heartRateCalculator.addHeartbeat();
        double heartRate = _heartRateCalculator.calculateHeartRate();
        _heartRateData.add(FlSpot(timer.tick.toDouble(), heartRate));
        // Check for atrial fibrillation
        _isFibrillationDetected = _detectAtrialFibrillation();
        _isRegular = !_isFibrillationDetected;

      });
    });
      void _loadBeatsPerMinute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      beatsPerMinute = prefs.getInt('beatsPerMinute') ?? 0;
    });
  }

  void _saveBeatsPerMinute(int bpm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('beatsPerMinute', bpm);
  }

  }

  bool _detectAtrialFibrillation() {
    if (_heartRateData.length < 30) {
      return false; // Not enough data for analysis
    } else if (_heartRateData.length < 20) {
      return false;
    } else if (_heartRateData.length < 10) {
      return false;
    } else if (_heartRateData.length < 5) {
      return false;
    } else if (_heartRateData.length < 1) {
      return false;
    }

    // Calculate the standard deviation of heart rate data
    List<double> heartRates = _heartRateData.map((spot) => spot.y).toList();
    double averageHeartRate = heartRates.reduce((a, b) => a + b) / heartRates.length;
    double sumDeviation = heartRates.fold(0, (prev, rate) => prev + math.pow(rate - averageHeartRate, 2));
    double standardDeviation = math.sqrt(sumDeviation / heartRates.length);

    // Set threshold for standard deviation
    double threshold = 10.0;

    // Check if standard deviation exceeds threshold
    return standardDeviation > threshold;
  }

  @override
  void dispose() {
    _heartRateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Monitor'),
      ),
      body: Container(
        width: 600,
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _isRegular ? 'Rhythm: Regular' : 'Rhythm: Irregular',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _isFibrillationDetected ? 'Atrial Fibrillation Detected!' : '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _heartRateData,
                      isCurved: true,
                      barWidth: 2,
                      color: Color.fromARGB(255, 0, 0, 0),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}