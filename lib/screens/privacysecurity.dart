import 'package:deskapp/barchat/headerwidget4.dart';
import 'package:flutter/material.dart';

class privacy extends StatefulWidget {
  const privacy({super.key});

  @override
  State<privacy> createState() => _privacyState();
}

class _privacyState extends State<privacy> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: Column(
        children: [
          Headerwidget4(),
          AlertDialog()
      ],),
    ),);
}
}
