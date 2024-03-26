import 'package:deskapp/screens/DashboardHome.dart';
import 'package:deskapp/screens/logindoc.dart';
import 'package:deskapp/screens/splashscreen.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) =>    const Dashboar(),  
        '/login':(context) =>    const LoginDoc(),  








        
      },
     
    );
  }
}

