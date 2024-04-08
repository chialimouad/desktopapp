import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/bannerdash.dart';
import 'package:deskapp/bargraph/linechart.dart';
import 'package:deskapp/bargraph/mybargraph.dart';
import 'package:deskapp/bargraph/piechart.dart';
import 'package:deskapp/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeLogin extends StatefulWidget {
final token, value;
const HomeLogin({Key? key, required this.token, this.value});

@override
State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
List? items;
late String userid;

@override
void initState() {
super.initState();
Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
userid = jwtDecodedToken['id'];
getUser(userid);
}

void getUser(userid) async {
var regbody = {
"userId": userid,
};
var response = await http.post(
Uri.parse("https://s4db.onrender.com/12/getuser"),
headers: {"Content-Type": "application/json"},
body: jsonEncode(regbody),
);
var newtoken = jsonDecode(response.body);
setState(() {
items = newtoken['success'];
});
}



@override
Widget build(BuildContext context) {
return Scaffold(

body: Expanded(
child: Center(
child: ListView(
children: [
Container(
height: double.maxFinite,
width: double.maxFinite,
decoration: BoxDecoration(
color: const Color.fromARGB(255, 255, 255, 255),
borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
),
child: Column(
children: [
WindowTitleBarBox(
child: Column(
children: [
Expanded(
child: MoveWindow(),
),
],
),
),
//header
Container(
height: 60,
width: double.maxFinite,
child: Headerwidget(),
),
Expanded(
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Padding(
padding: EdgeInsets.only(top: 25, bottom: 10),
child: Column(
children: [
Row(
children: [
SizedBox(width: 30),
Text(
"Active",
style: TextStyle(
decoration: TextDecoration.none,
color: Color.fromARGB(255, 0, 0, 0),
fontSize: 14,
),
),
SizedBox(width: 15),
CircleAvatar(radius: 5, backgroundColor: Colors.green),
],
),
],
),
),
Container(
width: 780,
child: Container(
child: Column(
children: [
Bannerdash(token: widget.token),
Padding(
padding: const EdgeInsets.all(20.0),
child: Center(
child: Row(
children: [
Container(
width: 300,
height: 200,
decoration: BoxDecoration(
color: Color.fromRGBO(255, 255, 255, 1),
boxShadow: [BoxShadow(blurRadius: 0.1)],
borderRadius: BorderRadius.circular(15),
),
child: RealTimeBarChart(),
),
SizedBox(width: 100),
Container(
width: 320,
height: 200,
decoration: BoxDecoration(
color: Colors.white,
boxShadow: [BoxShadow(blurRadius: 0.1)],
borderRadius: BorderRadius.circular(15),
),
child: RealTimeLineChartDemo(),
),
],
),
),
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
width: 300,
height: 300,
decoration: BoxDecoration(color: Colors.white),
child: Piechart1(),
),
SizedBox(width: 70),

Column(
children: [
Container(
  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(3),boxShadow: [
    BoxShadow(blurRadius: 0.3,offset: Offset(0.3,0.3),),
    
  ],
  ),
  width: 300,
  height: 30,
  child:
 Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Text('fullname'),
Text('Age'),
Text('willaya'),
Text('Status'),


],),

),
Container(
width: 300,
height: 300,
decoration: BoxDecoration(
color: Color.fromARGB(255, 255, 255, 255),
borderRadius: BorderRadius.circular(5),
boxShadow: [
    BoxShadow(blurRadius: 0.3,offset: Offset(0.3,0.3),),
    
  ],
),
child: items == null
? Container(
width: 400,
height: double.maxFinite,
child: Image.asset("images/nouser.jpg"),
)
: ListView.builder(
itemCount: items!.length,
itemBuilder: (context, int index) {
return Container(
color: Color.fromARGB(255, 255, 255, 255),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Container(
width: 350,
height: 40,
decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
BoxShadow(blurRadius: 1,offset: const Offset(1, 1))
]),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text('${items![index]['fullname']}'),
Text('${items![index]['Age']}'),
Text('${items![index]['willaya']}'),
CircleAvatar(radius: 5, backgroundColor: Colors.green),

],),
),
),
)
);
},
),
),
],
),
],
),
],
),
),
),
],
)
],
),
),
],
),
),
],
),
),
),
);
}
}
