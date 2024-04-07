import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

class Ecg extends StatefulWidget {
  Ecg({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _EcgState createState() => _EcgState();
}

class _EcgState extends State<Ecg> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              width: 800,
              height: 500,
              child: SfCartesianChart(
                  series: <LineSeries<LiveData, num>>[
                        LineSeries<LiveData, num>(
              onRendererCreated: (ChartSeriesController controller) {
                _chartSeriesController = controller;
              },
              dataSource: chartData,
              color: const Color.fromRGBO(192, 108, 132, 1),
              xValueMapper: (LiveData sales, _) => sales.time,
              yValueMapper: (LiveData sales, _) => sales.speed,
                        )
                      ],
                  primaryXAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 1,
                      title: AxisTitle(text: 'Time (seconds)')),
                  primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 0),
                      title: AxisTitle(text: 'Internet speed (Mbps)'))),
            )));
  }

  int time = 7;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (((math.Random().nextInt(505)+20)))));
    chartData.removeAt(0);
  
  }

  List<LiveData> getChartData() {
    return <LiveData>[

                          LiveData(2, 0),
                      LiveData(2.10, 0),
                      LiveData(2, 20),
                      LiveData(2.30, 0),
                      LiveData(2.40, 0),
                      LiveData(2.50, 0),
                      LiveData(2.60, 1),
                      LiveData(2.80, 3),
                      LiveData(2.90, 1),
                      LiveData(3.00, 2),
                      LiveData(3.10, 4),
                      LiveData(3.20, 5),
                      LiveData(3.30, 10),
                      LiveData(3.40, 15),
                      LiveData(3.50, 20),
                      LiveData(3.60, 15),
                      LiveData(3.70, -4),
                      LiveData(3.80, -3),
                      LiveData(3.90, -4),
                      LiveData(4.00, -6),
                      LiveData(4.10, -2),
                      LiveData(4.20, 0),
                      LiveData(4.30, -1),
                      LiveData(4.40, -1),
                      LiveData(4.50, -1),
                      LiveData(4.60, -2),

                      LiveData(4.70, 0),
                      LiveData(4.80, 2),
                      LiveData(4.90, 2),
                      LiveData(5.10, 2),
                      LiveData(5.20, 2),
                      LiveData(5.30, 0),
                      LiveData(5.40, 1),
                      LiveData(5.50, 3),
                      LiveData(5.60, 1),
                      LiveData(5.70, 2),
                      LiveData(5.80, 4),
                      LiveData(5.90, 5),
                      LiveData(6, 10),
                      LiveData(6.20, 15),
                      LiveData(6.30, 20),
                      LiveData(6.40, 15),
                      LiveData(6.50, -4),
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final num time;
  final num speed;
}


// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late List<LiveData> chartData;
//   late ChartSeriesController _chartSeriesController;
//   double y= 60-(math.Random().nextInt(130)/16);
   
//   @override
//   void initState() {
//     chartData = getChartData();
//     Timer.periodic(const Duration(seconds: 100), updateDataSource);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: Container(
//               width: 1000,
//               height: 400,
//               child: SfCartesianChart(
//                   series: <LineSeries<LiveData, num>>[
//                         LineSeries<LiveData, num>(
//               onRendererCreated: (ChartSeriesController controller) {
//                 _chartSeriesController = controller;
//               },
//               dataSource: chartData,
//               color: const Color.fromRGBO(192, 108, 132, 1),
//               xValueMapper: (LiveData sales, _) => sales.time,
//               yValueMapper: (LiveData sales, _) => sales.speed,
//                         )
//                       ],
//                   primaryXAxis: NumericAxis(
//                       majorGridLines: const MajorGridLines(width: 0),
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                       interval: 3,
//                       ),
//                   primaryYAxis: NumericAxis(
//                       axisLine: const AxisLine(width: 0),
//                       majorTickLines: const MajorTickLines(size: 0),
//                       )),
//             )));
//   }

//   int time = 19;
//   void updateDataSource(Timer timer) {
//     chartData.add(LiveData(time++, y));
//     chartData.removeAt(0);
//     _chartSeriesController.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//   }

//   List<LiveData> getChartData() {
//     return <LiveData>[

//                           LiveData(0, 0),
//                       LiveData(0.5, 0),
//                       LiveData(1, 0),
//                       LiveData(1.50, 0),
//                       LiveData(2.00, 0),
//                       LiveData(2.50, 0),
//                       LiveData(2.60, 1),
//                       LiveData(2.80, 3),
//                       LiveData(2.90, 1),
//                       LiveData(3.00, 2),
//                       LiveData(3.10, 4),
//                       LiveData(3.20, 5),
//                       LiveData(3.30, 10),
//                       LiveData(3.40, 15),
//                       LiveData(3.50, 20),
//                       LiveData(3.60, 15),
//                       LiveData(3.70, -4),
//                       LiveData(3.80, -3),
//                       LiveData(3.90, -4),
//                       LiveData(4.00, -6),
//                       LiveData(4.20, -2),
//                       LiveData(4.50, 0),
//                       LiveData(5.00, -1),
//                       LiveData(5.50, -1),
//                       LiveData(6.00, -1),
//                       LiveData(6.50, -2),
//                       LiveData(7.00, 0),
                     
//                       // LiveData(7.50, 2),
//                       // LiveData(8.00, 2),
//                       // LiveData(8.50, 2),
//                       // LiveData(9.00, 2),
//                       // LiveData(9.50, 0),
//                       // LiveData(9.60, 1),
//                       // LiveData(9.80, 3),
//                       // LiveData(9.90, 1),
//                       // LiveData(10.00, 2),
//                       // LiveData(10.10, 4),
//                       // LiveData(10.20, 5),
//                       // LiveData(10.30, 10),
//                       // LiveData(10.40, 15),
//                       // LiveData(10.50, 20),
//                       // LiveData(10.60, 15),
//                       // LiveData(10.70, -4),
//     ];
//   }
// }

// class LiveData {
//   LiveData(this.time, this.speed);
//   final num time;
//   final num speed;
// }