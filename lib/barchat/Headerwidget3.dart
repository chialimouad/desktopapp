import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Headerwidget3 extends StatefulWidget {
  const Headerwidget3({super.key});

  @override
  State<Headerwidget3> createState() => _Headerwidget3State();
}

class _Headerwidget3State extends State<Headerwidget3> {


  @override
  Widget build(BuildContext context) {
    return
       
        AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            
            color: Color.fromRGBO(255, 255, 255, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
          Image.asset("images/logomouad.png", width: 200, height: 200),
                Spacer(),
                   Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.privacy_tip_outlined),color: Color.fromRGBO(0, 0, 0, 1),),
                const SizedBox(width: 20,)    ,
                      IconButton(onPressed: (){}, icon: const Icon(Icons.update_rounded),color: Color.fromRGBO(0, 0, 0, 1),),
                
                ],)
                   
                
                ],),
              ),
            
          
            
            ),
        );
      
    
  }
}