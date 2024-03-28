import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
class Piechart1 extends StatefulWidget {
  const Piechart1({super.key});

  @override
  State<Piechart1> createState() => _Piechart1State();
}

class _Piechart1State extends State<Piechart1> {
  Map<String, double> dataMap = {
    "Stable": 50,
    "Unstable": 30,
    "Critical": 20,
    
  };
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 20/9,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: [Color.fromARGB(255, 42, 212, 118),Color.fromARGB(211, 255, 9, 9),Colors.orange],
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
          // decimalPlaces: 1,
        ),
       
      ),
    );
  }
}