
import 'package:deskapp/screens/DashboardHome.dart';
import 'package:deskapp/screens/splashscreen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main()async {
  
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
home: (JwtDecoder.isExpired(token)==false)?Dashboar(token: token,):Splashscreen(),
      
    );
  }
}

