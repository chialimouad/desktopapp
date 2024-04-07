import 'package:flutter/material.dart';

class History extends StatelessWidget {
  
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))),
        child: Container(
          width: 1000,

          height: 600,
          child: Image.asset('images/gifanim.gif',)),
        ),
    )
;
  }
}