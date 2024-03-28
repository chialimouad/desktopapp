import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bnnerdash extends StatelessWidget {
  const Bnnerdash({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/3,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(244, 242, 242, 1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
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
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                        Text("Alex Jimmy",style: TextStyle(color: Color.fromRGBO(216, 97, 97, 1),fontSize: 15,fontWeight: FontWeight.bold),),
                       const Text.rich(
                       TextSpan(
                        style: TextStyle(decoration: TextDecoration.none,color: Colors.black),
                        children: [ 
                          TextSpan(text: "Hello Doctor !  ",style: TextStyle(fontSize: 13)),
                         TextSpan(text: " Its look you are ready for today,your patients waiting for You ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),])
                      ),
        
                      const SizedBox(width: 19,),
                               Column(
              children: [ 
                SizedBox(height: 5,),                 
              TextButton.icon(
                   style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    backgroundColor: const Color.fromRGBO(216, 97, 97, 1),
                    shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
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
        ),
      ),
    );
  }
}