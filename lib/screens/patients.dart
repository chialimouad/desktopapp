import 'package:flutter/material.dart';

class Patients extends StatelessWidget {
  const Patients({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
      ),
      child: Text("data"),
      )
;
  }
}