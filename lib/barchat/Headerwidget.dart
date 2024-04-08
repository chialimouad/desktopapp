import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/barchat/headerwidget2.dart';
import 'package:deskapp/screens/test2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Headerwidget extends StatefulWidget {
  const Headerwidget({super.key});

  @override
  State<Headerwidget> createState() => _HeaderwidgetState();
}

class _HeaderwidgetState extends State<Headerwidget> {
final textcontroller = TextEditingController();
  List<String> searchResults = [];
   getdata() async {

     
      var res = await http.get(Uri.parse("https://s4db.onrender.com/12/finding"),
      
      );
      var resjson = jsonDecode(res.body);
      print(res.body);
      if (resjson['status']) {
        final List<dynamic> data = jsonDecode(res.body);
                setState(() {
                        searchResults=data.map((item) => item['fullname'] as String).toList();

                });

      } 
  
    
  }
  insertData() async {
  try{
      var regbody = {
        "fullname": textcontroller.text,
       
        
      };
      var res = await http.post(Uri.parse("https://s4db.onrender.com/12/finding"),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regbody)
      );
      var resjson = jsonDecode(res.body);
      print(res.body);
      if (resjson['status']) {
                                         
      showMyDialog('${resjson['success']!['fullname']}', '${resjson['success']['Age']}', '${resjson['success']['willaya']}', '${resjson['success']['phonenumber']}');

      } else {
         showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Item not Found'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

      }
  }catch(err){
       showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Item not Found'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
  }

    
  }
  @override
  Widget build(BuildContext context) {
    return
       
       
           Scaffold(
         
             body: Container(
              
              color: Color.fromRGBO(255, 255, 255, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                       Image.asset("images/logomouad.png",),
                  Spacer(),
                     Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.notifications),color: Color.fromRGBO(0, 0, 0, 1),),
                  const SizedBox(width: 20,)    ,
                        AnimSearchBar(width: 400, textController: textcontroller, onSuffixTap: (){
                          setState(() {
                            textcontroller.clear();
                          });
                        }, onSubmitted: (String ) {  insertData();},
                        helpText: "Serach Patient....",
                        closeSearchOnSuffixTap: true,
                        autoFocus: true,
                        animationDurationInMilli: 600,
                       rtl: true,
                        )
                  
                  ],)
                     
                  
                  ],),
                ),
              
                       
              
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
                      child: EcgChart(),
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
