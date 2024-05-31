import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class ECGGraph extends StatefulWidget {
  @override
  _ECGGraphState createState() => _ECGGraphState();
}

class _ECGGraphState extends State<ECGGraph> {
  List<int> ecgData = []; // List to store ECG data
  double time = 0; // Time variable to simulate ECG over time
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Simulate ECG data with a timer
    timer = Timer.periodic(Duration(milliseconds: 1000 ~/ 60), (Timer t) {
      // Generate ECG data using a sine function
      double value = 100 * math.sin(time) + 120; // Modify this formula as needed
      setState(() {
        // Add generated ECG value to the data list
        ecgData.add(value.round());
        // Increment time for the next data point
        time += 0.1; // Adjust the step size as needed
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECG Graph'),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.all(10),
          child: CustomPaint(
            painter: ECGPainter(ecgData),
          ),
        ),
      ),
    );
  }
}

class ECGPainter extends CustomPainter {
  final List<int> ecgData;

  ECGPainter(this.ecgData);

  @override
  void paint(Canvas canvas, Size size) {
    if (ecgData.isEmpty) return; // Check if data is available

    Paint linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double width = size.width / (ecgData.length - 1);

    Path path = Path();
    for (int i = 0; i < ecgData.length; i++) {
      double x = i * width;
      double y = size.height - ecgData[i].toDouble(); // Invert the data for proper rendering
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(ECGPainter oldDelegate) {
    return ecgData != oldDelegate.ecgData;
  }
}


