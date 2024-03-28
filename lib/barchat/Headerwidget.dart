import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Headerwidget extends StatefulWidget {
  const Headerwidget({super.key});

  @override
  State<Headerwidget> createState() => _HeaderwidgetState();
}

class _HeaderwidgetState extends State<Headerwidget> {
  
  @override
  Widget build(BuildContext context) {
    return
       
        AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            
            color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
          Text("PULSE X",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,decoration: TextDecoration.none,color: Colors.black),),
                Spacer(),
                   Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.notifications),color: Color.fromRGBO(0, 0, 0, 1),),
                const SizedBox(width: 20,)    ,
                      IconButton(onPressed: (){}, icon: const Icon(Icons.search),color: Color.fromRGBO(0, 0, 0, 1),),
                
                ],)
                   
                
                ],),
              ),
            
          
            
            ),
        );
      
    
  }
}