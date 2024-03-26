import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bnnerdash extends StatelessWidget {
  const Bnnerdash({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 1,
              color: Color.fromARGB(255, 93, 92, 92)
            )
          ]
          ),
          padding: EdgeInsets.all(20),
          child:    Column(
            children: [
              Row(
                children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
              
                   const Text.rich(
                   TextSpan(
                    style: TextStyle(decoration: TextDecoration.none,color: Colors.black),
                    children: [ 
                      TextSpan(text: "Hello Doctor !  ",style: TextStyle(fontSize: 13)),
                     TextSpan(text: "   Its look you are ready for today,your patients waiting for You ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),])
                  ),
                  const SizedBox(width: 19,),
                            Image.asset("images/doctor.png",width: 40,height: 40,),
                           Column(
          children: [                  
          TextButton.icon(
               style: TextButton.styleFrom(
                textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                backgroundColor: const Color.fromRGBO(216, 97, 97, 1),
                shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
                ), 
              ),
            onPressed: (){}, icon: const Icon(Icons.history), label: Text('History',style: TextStyle(color: Colors.white),))
          ],)
                        
                                  
            
                ],
                ),
              
                ],
                ),
            ],
          ),
            
          ),
        ),
      ],
    );
  }
}