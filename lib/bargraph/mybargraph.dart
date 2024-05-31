import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCountModel extends ChangeNotifier {
  late List<int> userCountByDay;

  UserCountModel() {
        userCountByDay = List<int>.filled(7, 0);

    _loadUserCountFromPrefs();
  }

  void _loadUserCountFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userCountJson = prefs.getString('userCountByDay');
    if (userCountJson != null) {
      userCountByDay = List<int>.from(jsonDecode(userCountJson));
    } else {
      // Initialize with zeros if no data is found in SharedPreferences
      userCountByDay = List<int>.filled(7, 0);
    }
    notifyListeners();
  }

  Future<void> _saveUserCountToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userCountByDay', jsonEncode(userCountByDay));
  }

  void addUser() {
    // Logic to add user and update user count for the current day
    final currentDayIndex = DateTime.now().weekday % 7;
    userCountByDay[currentDayIndex]++;
    // Save updated user count to SharedPreferences
    _saveUserCountToPrefs();
    notifyListeners();
  }
    void minuser() {
    // Logic to add user and update user count for the current day
    final currentDayIndex = DateTime.now().weekday % 7;
    userCountByDay[currentDayIndex]--;
    // Save updated user count to SharedPreferences
    _saveUserCountToPrefs();
    notifyListeners();
  }
}

class UserCountPage extends StatelessWidget {
          FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
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
    Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Sn';
        break;
      case 1:
        text = 'Mn';
        break;
      case 2:
        text = 'Te';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'Tu';
        break;
      case 5:
        text = 'Fr';
        break;
      case 6:
        text = 'St';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }
  @override
  Widget build(BuildContext context) {
    final userCountModel = Provider.of<UserCountModel>(context);
    List<int> userCounts = Provider.of<UserCountModel>(context).userCountByDay;

    final int totalUserCount = userCountModel.userCountByDay.fold<int>(0, (prev, count) => prev + count);

    final List<BarChartGroupData> barChartData = List.generate(7, (index) {
      final double value = userCountModel.userCountByDay[index].toDouble();
      return BarChartGroupData(x: index, barRods: [BarChartRodData(toY: value)]);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(' ${totalUserCount}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: userCountModel.userCountByDay.reduce((value, element) => value > element ? value : element).toDouble(),
            minY: 0,
            barTouchData: BarTouchData(enabled: false),
            titlesData: titlesData,
            gridData: FlGridData(show: false),

            borderData: FlBorderData(show: false),
            barGroups: barChartData,
          ),
        ),
      ),
    );
  }
}