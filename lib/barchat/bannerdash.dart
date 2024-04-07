import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Bannerdash extends StatefulWidget {
  final token;
  const Bannerdash({super.key, this.token});

  @override
  State<Bannerdash> createState() => _BannerdashState();
}

class _BannerdashState extends State<Bannerdash> {
    late String name;

  @override
void initState() {
// TODO: implement initState
super.initState();
Map<String,dynamic> jwtDecodedToken =JwtDecoder.decode(widget.token);
name=jwtDecodedToken['fullname'];


}
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
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.96),
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
                        Text(name,style: TextStyle(color: Color.fromRGBO(4, 62, 117, 0.95),fontSize: 15,fontWeight: FontWeight.bold),),
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
                    backgroundColor: const Color.fromRGBO(4, 62, 117, 0.95),
                    shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
                    ), 
                  ),
                onPressed: (){}, icon: const Icon(Icons.history,color: Colors.white,), label: Text('History',style: TextStyle(color: Colors.white),))
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