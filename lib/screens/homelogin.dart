import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/bannerdash.dart';
import 'package:deskapp/bargraph/mybargraph.dart';
import 'package:deskapp/bargraph/piechart.dart';
import 'package:deskapp/screens/logindoc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeLogin extends StatefulWidget {
const HomeLogin({super.key,});

@override
State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
List<double> weekly=[
30.9,
50.8,
6.8,
0.7,
19,6,
50.98,
4,0
];
@override
Widget build(BuildContext context) {
return Scaffold(
body: 
 Container(
width: MediaQuery.of(context).size.width,
 height: MediaQuery.of(context).size.height,
decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255),borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))),
child: Column(
children: [

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

   Expanded(
  child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  const Padding(
  padding: EdgeInsets.only(top: 25,bottom: 10),
  child: Column(
  children: [  
  Row(children: [  
  SizedBox(width: 30,),                     
  Text("Active",style: TextStyle(decoration: TextDecoration.none,color: Color.fromARGB(255, 0, 0, 0),fontSize: 14),),
  SizedBox(width: 15,),
  CircleAvatar(radius: 5,backgroundColor: Colors.green,),
  ],)
  ],),
  ),
  Container(
  width: 780,
  child:   Container(
  
  child:  Column(
  children: [
  Bnnerdash() ,
  Padding(
  padding: const EdgeInsets.all(20.0),
  child: Center(
  child: Row(
  children: [
  Container(
  width: 300,
  height: 150,
  decoration: BoxDecoration(color: Colors.white,
  boxShadow: const[
  BoxShadow(
  offset: const Offset(0,0),
  spreadRadius: 0.2,
  blurRadius: 0.2,
  color: Colors.black
  )
  ]
  ,
  borderRadius: BorderRadius.circular(30)),
  child:
   BarChartSample3()    , 
  
  ),
  SizedBox(width: 100,),
  Container(
  
  width: 300,
  height: 150,
  decoration: BoxDecoration(color: Colors.white,
  
  
  borderRadius: BorderRadius.circular(30)),
  child: Piechart1()
  ),
  
  ],
  ),
  ),
  ),],
  ),)
  ),
  ],
  ),
  ],
  )
  ),


],
),

),

);
}
}