
import 'package:deskapp/screens/DashboardHome.dart';
import 'package:deskapp/screens/addusers.dart';
import 'package:deskapp/screens/allpatients.dart';
import 'package:deskapp/screens/logindoc.dart';

import 'package:deskapp/screens/test.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  runApp(
    
    
       MyApp(token: prefs.getString('token'),usertoken: prefs.getString('user'),));
}

class MyApp extends StatelessWidget {
  final token,usertoken;
    const MyApp({
      Key? key, 
      required this.token, this.usertoken,
      }):super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
home: (JwtDecoder.isExpired(token)==false)?Dashboar(token: token,):LoginDoc(),
     //home: MyHomePage(title: 'mouad',),
    );
  }
}

