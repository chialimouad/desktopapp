
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/test34.dart';
import 'package:deskapp/bargraph/linechart.dart';
import 'package:deskapp/bargraph/mybargraph.dart';
import 'package:deskapp/bargraph/piechart.dart';
import 'package:deskapp/screens/DashboardHome.dart';
import 'package:deskapp/screens/ecg.dart';
import 'package:deskapp/screens/homelogin.dart';
import 'package:deskapp/screens/logindoc.dart';
import 'package:deskapp/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main()async {
     // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  runApp(
    
    
       MyApp(token: prefs.getString('token')));
}

class MyApp extends StatelessWidget {
  final token;
    const MyApp({
      Key? key, 
       this.token,
      }):super(key: key);

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
    providers: [
       ChangeNotifierProvider<AverageBPMModel>(
            create: (_) => AverageBPMModel(),
          ),
           ChangeNotifierProvider<notifbpm>(
            create: (_) => notifbpm(),
          ),
           ChangeNotifierProvider<status>(
            create: (_) => status(),
          ),
      ChangeNotifierProvider<UserCountModel>(
        create: (_) => UserCountModel(), 
      ),
    ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          // Use the builder context to access the provider
          return (JwtDecoder.isExpired(token)==false)?Dashboar(token: token,):Splashscreen();
          
         //return HeartRateChart1();
        },
      ),
    ),
  );
 
  }
}

