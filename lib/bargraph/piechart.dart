import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
class AverageBPMModel extends ChangeNotifier {
  late double averageBPM=0.0;

  void setAverageBPM(double value) {
    averageBPM = value;
    
  }
}

class Piechart1 extends StatefulWidget {
  const Piechart1({super.key});

  @override
  State<Piechart1> createState() => _Piechart1State();
}

class _Piechart1State extends State<Piechart1> {
  late double receivedValue;

  @override
  void initState() {
    super.initState();
    receivedValue = Provider.of<AverageBPMModel>(context, listen: false).averageBPM;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {};

    if (receivedValue < 50) {
      dataMap = {
        "Stable": 0,
        "Unstable": 0,
        "Critical": 100,
      };
    } else if (receivedValue >= 50 && receivedValue <= 120) {
      dataMap = {
        "Stable": 100,
        "Unstable": 0,
        "Critical": 0,
      };
    } else {
      dataMap = {
         "Stable": 0,
        "Unstable":100,
        "Critical": 0,
      };
    }

    List<Color> colorList = [
      Colors.red,
      Colors.orange,
      Colors.green,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Alert  ",
              style: TextStyle(fontSize: 20),
            ),
            Icon(
              Icons.dangerous,
              color: Colors.red,
            )
          ],
        ),
      ),
      body: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: colorList,
        chartType: ChartType.ring,
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          chartValueBackgroundColor: Colors.white,
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesOutside: true,
        ),
      ),
    );
  }
}
