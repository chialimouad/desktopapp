import 'dart:async';
import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/headerwidget2.dart';
import 'package:deskapp/bargraph/mybargraph.dart';
import 'package:deskapp/screens/ecgchartfreq.dart';
import 'package:deskapp/screens/homelogin.dart';
import 'package:deskapp/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

class Allpatient extends StatefulWidget {
  final String token;

  const Allpatient({required this.token, Key? key}) : super(key: key);

  @override
  State<Allpatient> createState() => _AllpatientState();
}

class _AllpatientState extends State<Allpatient> {
  late String userId;
  late StreamController<List> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List>.broadcast();
    final jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['id'];
    getuser(userId);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void getuser(String userId) async {
    final regbody = {
      "userId": userId,
    };
    final response = await http.post(
      Uri.parse("https://s4db.onrender.com/12/getuser"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regbody),
    );
    final newtoken = jsonDecode(response.body);
    _streamController.sink.add(newtoken['success']);
  }

  void deleteuser(String id) async {
    final regbody = {
      "id": id,
    };
    final res = await http.post(
      Uri.parse("https://s4db.onrender.com/12/delete"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regbody),
    );
    final neww = jsonDecode(res.body);
    if (neww['status']) {
      getuser(userId);
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Container(
          height: 60,
          width: double.maxFinite,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Headerwidget(),
          )),
     
        Expanded(
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.white,
            child: StreamBuilder<List>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List items = snapshot.data as List;
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('Full Name')),
                      DataColumn(label: Text('Age')),
                      DataColumn(label: Text('Willaya')),
                      DataColumn(label: Text('Phone Number')),
                      DataColumn(label: Text('Status')),
                       DataColumn(label: Text('Bpm')),

                      DataColumn(label: Text('Actions')),
                    ],
                    rows: items.map((item) {
                      return DataRow(cells: [
                        DataCell(Text('${item['fullname']}')),
                        DataCell(Text('${item['Age']}')),
                        DataCell(Text('${item['willaya']}')),
                        DataCell(Text('${item['phonenumber']}')),
                        DataCell(CircleAvatar(radius: 4,backgroundColor: Colors.green,)),
                        DataCell(Text('88')),

                        DataCell(Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                deleteuser('${item['_id']}');
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                            IconButton(
                              onPressed: () {
                                showMyDialog('${item['fullname']}', '${item['Age']}', '${item['willaya']}', '${item['phonenumber']}');
                              },
                              icon: Icon(Icons.more_horiz, color: Colors.black),
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ],
    ),
  );
}


  Future<void> showMyDialog(String name, String age, String willaya, String Number) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: ListView(
            children: [
              Column(
                children: [
                  WindowTitleBarBox(
                    child: Column(
                      children: [
                        Expanded(child: MoveWindow()),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    child: Headerwidget2(),
                  ),
                  Container(
                    color: Colors.white10,
                    child: Column(
                      children: [
                        Text(" The name of your Patient :$name"),
                        Text(" The age of your Patient :$age"),
                        Text(" The willaya of your Patient :$willaya"),
                        Text(" The Phone Number  of your Patient :+$Number"),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 500,
                      height: 500,
                      child: Ecg(title: "title"),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 500,
                      height: 500,
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
