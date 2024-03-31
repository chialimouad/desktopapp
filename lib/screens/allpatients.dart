import 'dart:convert';


import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:card_actions/card_action_button.dart';
import 'package:card_actions/card_actions.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/headerwidget2.dart';
import 'package:deskapp/screens/ecgchartfreq.dart';
import 'package:deskapp/screens/stat.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

class Allpatient extends StatefulWidget {
  final token;
  const Allpatient({required this.token,super.key});

  @override
  State<Allpatient> createState() => _AllpatientState();
}

class _AllpatientState extends State<Allpatient> {
     List? items;
late String userid;
@override
void initState() {
// TODO: implement initState
super.initState();
Map<String,dynamic> jwtDecodedToken =JwtDecoder.decode(widget.token);

userid=jwtDecodedToken['id'];
getuser(userid);
//getdatauser(emailconfirm);
}
GlobalKey key=GlobalKey();
        final emailconfirm=TextEditingController();
  //  void getdatauser(email)async{
   
  //       var regbody={
  //         "email":emailconfirm.text,
  //       };
  //       var response=await http.post(Uri.parse("https://s4db.onrender.com/12/getuserspecial"),headers: {"Content-Type":"application/json"},
        
  //       body: jsonEncode(regbody));
  //       var newtoken=jsonDecode(response.body);
  //       print(newtoken);
      
       
      
  //   }
            
        bool? isemail;
Future<void> showMyDialog(String name,String age,String willaya,String Number) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Dialog.fullscreen(
        
       
        child:Column(
          children: [
            WindowTitleBarBox(
                      child: Column(
                        children: [
                          Expanded(
                            child: MoveWindow())],),
                            ),
                            //header
                       Container(
                        height: 40,
                        width: double.maxFinite,
                        child: Headerwidget2()),
            Container( color: Colors.white10,child: Row(children: [
              Text(name),
              Text(age),
              Text(willaya),
            Text(Number),

            ],
            ),
            ),
            Center(
              child: Container(
                width: 500,
                height: 500,
                child: Ecg(title: "title")),
            ),
          ],
        ),
     
      );
    },
  );
}
   void getuser(userid)async{
   
        var regbody={
          "userId":userid,
        };
        var response=await http.post(Uri.parse("https://s4db.onrender.com/12/getuser"),headers: {"Content-Type":"application/json"},
        
        body: jsonEncode(regbody));
        var newtoken=jsonDecode(response.body);
        items =newtoken['success'];
        setState(() {
          
        });

      
    }
   void deleteuser(id)async{
  
        var regbody={
          "id":id,
        };
        var res=await http.post(Uri.parse("https://s4db.onrender.com/12/delete"),headers: {"Content-Type":"application/json"},
        
        body: jsonEncode(regbody));
        var neww=jsonDecode(res.body);
          if(neww['status']){
             getuser(userid);
      
          }
      
    }
  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
      body: 
       Expanded(
   child: Center(
     child: ListView(
       children: [
        Container(
       height: double.maxFinite,
       width: double.maxFinite,
       decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255),borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))),
       child: Column(
       children: [
       
       WindowTitleBarBox(
       child: Column(
       children: [
       Expanded(
       child: MoveWindow())],),
       ),
       //header
       Container(
       height: 40,
       width: double.maxFinite,
       child: Headerwidget()),
       
         Expanded(
        child:
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       
    Container(
                    
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Fullname'),
    Text('Age'),
    Text('Willaya'),
    Text('Phonenumber'),
    Text('Bpm'),
    Text('Rythme'),
        Text('Rythme',style: TextStyle(color: Colors.white),),

                          
                          ],
                        ),
                        ),
                        
                        
                  ),
    
             Container(
                width: 1000,
                height: 1000,
                color: Colors.white,
                child: items==null?
                Container(
                  width: double.maxFinite,height: double.maxFinite,
                child: Image.asset("images/nouser.jpg"),):ListView.builder(
                  itemCount: items!.length,itemBuilder: (context,int index){
                  return 
      // CardActionButton
    
                     Card(
                      child: ListTile(
                        
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('${items![index]['fullname']}'),
                            Text('${items![index]['Age']}'),
                            Text('${items![index]['willaya']}'),
                            Text('${items![index]['phonenumber']}'),
                            Text('88'),
                            Text('regular'),
                            CircleAvatar(radius: 5,backgroundColor: Colors.green,)
                          ],
                          
                        ),
                        trailing: 
                          
                            TextButton.icon(onPressed: (){
                              deleteuser('${items![index]['_id']}');
                                // showMyDialog('${items![index]['fullname']}','${items![index]['Age']}','${items![index]['willaya']}','${items![index]['phonenumber']}');
                            }, icon: Icon(Icons.arrow_circle_right,color: Colors.black,), label: Text("more"))
                          
                        
                        ),
                        
                        );
                  
                            
                },),),
        
       
        
        
        ],
        ),
       
        ),
       
       
       ],
       ),
       
       ),],
     ),
   ),
 ),
        
      );
    

  }
}