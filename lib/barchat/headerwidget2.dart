import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Headerwidget2 extends StatefulWidget {
  const Headerwidget2({super.key});

  @override
  State<Headerwidget2> createState() => _Headerwidget2State();
}

class _Headerwidget2State extends State<Headerwidget2> {
  
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
                   Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                const SizedBox(width: 20,)    ,
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_circle_left_outlined),color: Color.fromRGBO(0, 0, 0, 1),),
                
                ],)
                   
                
                ],),
              ),
            
          
            
            ),
        );
      
    
  }
}