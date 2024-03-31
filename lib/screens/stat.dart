import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:flutter/material.dart';

class Stat extends StatelessWidget {
  final token;
  const Stat({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: ListView(
          children: [
            Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                       WindowTitleBarBox(
                        child: Column(
                          children: [
                            Expanded(
                              child: MoveWindow())],),
                              ),
                              //header
                         Container(
                          height: 40,
                          width: double.maxFinite,
                          child: Headerwidget()),
              ],),
            ),
          ),]
        ),
      ),
    )
;
  }
}