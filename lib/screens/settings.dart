import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/Headerwidget3.dart';
import 'package:deskapp/screens/logindoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
final token;
const Settings({required this.token,super.key});

@override
State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
late String email;
late String name;
late int age;
late String willaya;
late String Spec;
late int phone;
late String pass;
late String id;

 void deleteuser(String id) async {
    final regbody = {
      "id": id,
    };
    final res = await http.post(
      Uri.parse("https://s4db.onrender.com/12/deletedoc"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regbody),
    );
    final neww = jsonDecode(res.body);
    if (neww['status']) {
               Navigator.push(context, MaterialPageRoute(builder: ((context) =>LoginDoc())));
    }
  }
@override
void initState() {
// TODO: implement initState
super.initState();
Map<String,dynamic> jwtDecodedToken =JwtDecoder.decode(widget.token);
email=jwtDecodedToken['email'];
name=jwtDecodedToken['fullname'];
age=jwtDecodedToken['Age'];
willaya=jwtDecodedToken['willaya'];
pass=jwtDecodedToken['password'];
Spec=jwtDecodedToken['Specialite'];
phone=jwtDecodedToken['phonenumber'];
    id = jwtDecodedToken['id'];
}
@override
Widget build(BuildContext context) {
return 
Scaffold(
body: ListView(
  children: [Column(
    
    children: [
      Container(
        width: double.maxFinite,
        height: 70,
        child: Headerwidget3()),
              Text("Your Personal Information Dr.${name}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),

      
         Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 255, 255, 255),borderRadius: BorderRadius.circular(20)),
        child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          SizedBox(height: 30,),
                  Text("email address :  ",style: TextStyle(color: Color.fromRGBO(0, 52, 102, 1),fontSize: 16,fontWeight: FontWeight.normal),),
     SizedBox(height: 10,),
        Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.733),borderRadius: BorderRadius.circular(5),),
  
        width: 400,height: 60,
        
        child: Row(
          children: [
            
            Container(
              height: double.maxFinite,
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(1)),
              child: 
                  Icon(Icons.email,color: Color.fromRGBO(0, 52, 102, 1),),
                
            
              ),
            SizedBox(width: 10,),
            Text(email,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
            
          ],
        ),
        ),
       
      
        ],), SizedBox(height: 10,),
  
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                            Text("Willaya  :  ",style: TextStyle(color: Color.fromRGBO(0, 52, 102, 1),fontSize: 16,fontWeight: FontWeight.normal),),
                            SizedBox(height: 10,),

          Container(
           decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.733),borderRadius: BorderRadius.circular(5),),
  
        width: 400,height: 40,
        
        child: Row(
          children: [
                Container(height: double.maxFinite,
                                                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(1)),
  
                  child: Icon(Icons.streetview,color: Color.fromRGBO(0, 52, 102, 1),)),
        
            Text(   willaya,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  
          ],
        ),
        ),
        
   
     
        
        
        ],), SizedBox(height: 30,),
  
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Phone Number  :  ",style: TextStyle(color: Color.fromRGBO(0, 52, 102, 1),fontSize: 16,fontWeight: FontWeight.normal),),
              Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.733),borderRadius: BorderRadius.circular(5),),
                
                      width: 400,height: 40,
                      
                      child: Row(
              children: [
                    Container( height: double.maxFinite,
                
                      
                                              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(1)),
                
                      child: Icon(Icons.phone,color: Color.fromRGBO(0, 52, 102, 1),)),
                      
                Text(" +${phone}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
              ],
                      ),
                      ),
            ],
          ),      SizedBox(height: 30,),
  
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Age:  ",style: TextStyle(color: Color.fromRGBO(0, 52, 102, 1),fontSize: 16,fontWeight: FontWeight.normal),),
              Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.733),borderRadius: BorderRadius.circular(5),),
                
                      width: 400,height: 40,
                      
                      child: Row(
              children: [
                    Container( height: double.maxFinite,
                
                      
                                              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(1)),
                
                      child: Icon(Icons.phone,color: Color.fromRGBO(0, 52, 102, 1),)),
                      
                Text(" +${age}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
              ],
                      ),
                      ),
            ],
          ),      SizedBox(height: 30,),
              
  
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Fullname  :  ",style: TextStyle(color: Color.fromRGBO(0, 52, 102, 1),fontSize: 16,fontWeight: FontWeight.normal),),
              Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.733),borderRadius: BorderRadius.circular(5),),
                
                      width: 400,height: 40,
                      
                      child: Row(
              children: [
                    Container( height: double.maxFinite,
                
                      
                                              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(1)),
                
                      child: Icon(Icons.phone,color: Color.fromRGBO(0, 52, 102, 1),)),
                      
                Text(" ${name}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
              ],
                      ),
                      ),
            ],
          ),      SizedBox(height: 30,),
     
       Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Password  :  ",style: TextStyle(color: Color.fromRGBO(0, 52, 102, 1),fontSize: 16,fontWeight: FontWeight.normal),),
              Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.733),borderRadius: BorderRadius.circular(5),),
                
                      width: 400,height: 40,
                      
                      child: Row(
              children: [
                    Container( height: double.maxFinite,
                
                      
                                              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(1)),
                
                      child: Icon(Icons.phone,color: Color.fromRGBO(0, 52, 102, 1),)),
                      
                Text(" ************",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
              ],
                      ),
                      ),
            ],
          ),      SizedBox(height: 30,),
              
  
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Specialite :  ",style: TextStyle(color: Color.fromRGBO(0, 52, 102, 1),fontSize: 16,fontWeight: FontWeight.normal),),
              Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.733),borderRadius: BorderRadius.circular(5),),
                
                      width: 400,height: 40,
                      
                      child: Row(
              children: [
                    Container( height: double.maxFinite,
                
                      
                                              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(1)),
                
                      child: Icon(Icons.phone,color: Color.fromRGBO(0, 52, 102, 1),)),
                      
                Text(" +${Spec}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
              ],
                      ),
                      ),
            ],
          ),      SizedBox(height: 20,),
        ],),
        ),
        ),
      Container(
                      decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black,width: 1),borderRadius: BorderRadius.circular(5)),
              height: 300,
        child: Row(
          children: [
            Container(
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontWeight: FontWeight.bold,color: Colors.white)),
                onPressed: (){
                
                 AwesomeDialog(
                  width: 400,
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.bottomSlide,
                title: 'Delete Your Account',
                desc: 'Are You Sure!',
                btnOkOnPress: () {deleteuser(id);},
              ).show();
                
              }, icon: Icon(Icons.delete), label: Text("delete")),
            ),
          ],
        ),
      ),

      SizedBox(height: 30,)
    ],
  ),]
),



);

;
}
}