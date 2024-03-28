import 'dart:convert';

import 'package:deskapp/screens/infos.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Allpatient extends StatefulWidget {
  final token;
  const Allpatient({required this.token,super.key});

  @override
  State<Allpatient> createState() => _AllpatientState();
}

class _AllpatientState extends State<Allpatient> {
        TextEditingController emailconfirm = TextEditingController();
late SharedPreferences prefs;
@override
void initState(){
super.initState();
initshared();
loginuser();
}
initshared()async{
prefs =await SharedPreferences.getInstance();
}
    loginuser()async{
    if(emailconfirm.text.isNotEmpty){
        var regbody={
          "email":emailconfirm.text,
        };
        var response=await http.post(Uri.parse("https://s4db.onrender.com/12/loginuser"),headers: {"Content-Type":"application/json"},
        
        body: jsonEncode(regbody));
        var newtoken=jsonDecode(response.body);
        if(newtoken['status']){
          var usertoken=newtoken['usertoken'];
          prefs.setString('usertoken', usertoken);
           Navigator.push(context, MaterialPageRoute(builder: ((context) => Infos(token: usertoken))));

        }
        print(newtoken);
      }
    }

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
         body: Expanded(
           child: Column(
             children: [
                 TextFormField(

controller: emailconfirm,
autofocus: true,                                    
decoration: InputDecoration(
labelText: "Email:",
border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
)),),
ElevatedButton(onPressed: (){
  loginuser();
}, child: Text("Clicknow")),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                    color: Colors.red,
                     child: Center(
                       child:Text( "hhhhhh")
                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),
       );
    
;
  }
}