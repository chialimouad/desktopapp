// ignore: file_names

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class LoginDoc extends StatelessWidget {
  const LoginDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(children: [
        
        Left(),
        Right(),
      ],),
      
    );
  }
}
class Left extends StatelessWidget {
  const Left({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [Image.asset("images/PULSE.png",width: 200,height: 200,)
         
        ],),
        width: double.infinity,
        height: double.infinity,
      
        decoration: const BoxDecoration(gradient:  LinearGradient(begin: Alignment.topLeft,
        end: Alignment.bottomRight,colors: [Colors.redAccent,Color.fromARGB(255, 240, 194, 134)],stops: [0.0,1.0]),
        image: DecorationImage(image: AssetImage("images/doc.png")
        
        ),
        ),
      ),
    );
  }
}
class Right extends StatefulWidget {
  const Right({super.key});

  @override
  State<Right> createState() => _RightState();
}

class _RightState extends State<Right> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
   insert()async {
// ignore: avoid_print
print("huhujikjkkk");

    var res=  await http.post(Uri.parse("https://new-95nd.onrender.com/register"),body:{
      "email":email.text,
      "password":pass.text,});
      
     if(res.statusCode==200){
               Navigator.pushNamed(context, '/Dash');

     }
      
 
}

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(
                  child: MoveWindow()
                  ),const Windows()
                  ],
                  ),
                  ),
                  
                 Expanded(
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      
                       Container(
                                          width: 400,height: 450,decoration: const 
                                          BoxDecoration(color: Colors.white,boxShadow: [
                                           BoxShadow(
                                            color: Colors.black54,
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0
                                          ),
                                          
                                          ],
                                          
                                                             
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                           ),
                                           child:  SafeArea(
                                             child:  Padding(
                                               padding: const EdgeInsets.only(top: 50,left: 10),
                                               
                                                 child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                  
                                                  const Text("  WELCOME ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                                                  const Text("   Dr. ",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                                                  const SizedBox(height: 20,),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    
                                                    child: Center(
                                                      child: Form(
                                                        
                                                        child: Column(children: [
                                                        
                                                        TextFormField(
                                                          
                                                          controller: email,
                                                          autofocus: true,                                    
                                                           decoration: InputDecoration(
                                                            labelText: "Email:",
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                            )),),
                                                            const SizedBox(height: 20,),
                                                             TextFormField(
                                                             obscureText: true,
                                                          controller: pass,
                                                          decoration: InputDecoration(
                                                            labelText: "Password:",
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                            )),),
                                                            const SizedBox(height: 50,),
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                                          
                                                          onPressed: (){
                                                            insert();
                                                          
                                                        }, child: const Text("Login Dr",style: TextStyle(color: Colors.white),)),
                                                        const SizedBox(height: 20,),
                                                        const Text(" Optimal Health and Well-being")
                                                        ],
                                                        ),
                                                        ),
                                                    ),
                                                 
                                                  ),
                                                 
                                                 ],
                                                 
                                                 ),
                                               
                                               
                                             ),
                                           ),
                                                             
                                                                 ),
                     ],
                   ),
                 ),
                
            
          
        ],
        
      
      ),
    
    
        );
  }
}
var window = WindowButtonColors(
  mouseDown: Colors.white,
  mouseOver: Colors.white,
  iconMouseDown: Colors.white10,
  iconNormal: Colors.black,
);
class Windows extends StatelessWidget {
  const Windows({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [MinimizeWindowButton(colors: window,),MaximizeWindowButton(colors: window,),CloseWindowButton(colors: window,)],);
  }
}