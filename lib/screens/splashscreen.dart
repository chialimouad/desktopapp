import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:deskapp/screens/logindoc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //     Future.delayed(Duration(seconds: 5),(){
  //      Navigator.pushNamed(context, '/login');
  //     });
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      
      child: AnimatedSplashScreen(
        splashIconSize: 200,
        duration: 250,
        splash: Container(
          width: 600,
          height: 700,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255)
           ),
              child: Image.asset("images/PulseLogo1.png",),
        ),
        nextScreen: LoginDoc(),
        splashTransition: SplashTransition.rotationTransition,
        
      ),
    );
  }
}