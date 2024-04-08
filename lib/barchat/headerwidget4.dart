import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Headerwidget4 extends StatefulWidget {
  const Headerwidget4({super.key});

  @override
  State<Headerwidget4> createState() => _Headerwidget4State();
}

class _Headerwidget4State extends State<Headerwidget4> {
  
  @override
  Widget build(BuildContext context) {
    return
       
        AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            
            color: Color.fromRGBO(255, 255, 255, 0.949),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
              Image.asset("images/logomouad.png", width: 200, height: 200),
                Spacer(),
                
                
                ],),
              ),
            
          
            
            ),
        );
      
    
  }
}