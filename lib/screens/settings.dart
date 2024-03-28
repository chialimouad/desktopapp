import 'package:flutter/material.dart';
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
body: 

 
AspectRatio(
aspectRatio: 16/9,
child: Container(
child: Container(
padding: EdgeInsets.all(10),
decoration: BoxDecoration(
boxShadow: [
BoxShadow(
blurRadius: 1
)
],
color: Color.fromARGB(255, 255, 255, 255),borderRadius: BorderRadius.circular(20)),
child: Padding(
padding: const EdgeInsets.all(12.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceAround,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Your Personal Information Dr.${name}"),
Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Container(
width: 300,height: 40,
child: Center(
child: Row(
  children: [
    Text("  Email:",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
    SizedBox(width: 10,),
    Text(email,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  ],
)),
),
Container(
width: 300,height: 40,

child: Center(child: Row(
  children: [
    Text("Fullname:",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
    SizedBox(width: 10,),
    Text(name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  ],
)),
),
Container(

width: 300,height: 40,

child: Center(child: Row(
  children: [
    Text("  Age:",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
    SizedBox(width: 10,),
    Text("${age}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  ],
)),
),
],),
Row(children: [
  Container(

width: 300,height: 40,

child: Row(
  children: [
        Text("  Willaya :  ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),

    Text(willaya,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  ],
),
),
Container(
 
width: 300,height: 40,

child: Row(
  children: [
        Text("   Phonenumber :  ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),

    Text("${phone}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  ],
),
),
Container(
width: 300,height: 40,
decoration: BoxDecoration(color: Colors.white,border: Border.symmetric(vertical: BorderSide(width: 0.5,color: Color.fromRGBO(216, 97, 97, 1)))),

child: Row(
  children: [
        Text("    Specialite :  ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),

    Text(Spec,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  ],
),
),


],),
Container(
width: 300,height: 40,

child: Row(
  children: [
        Text(" Password:  ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),

    Text("************",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
  ],
),
),
],),
),
),
),
),


);

;
}
}