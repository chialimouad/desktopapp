import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/Headerwidget3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
        height: 100,
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
          ),      SizedBox(height: 30,),
        ],),
        ),
        ),
      
    ],
  ),]
),



);

;
}
}