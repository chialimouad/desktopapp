import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Addusers extends StatefulWidget {
  const Addusers({super.key});

  @override
  State<Addusers> createState() => _AddusersState();
}

class _AddusersState extends State<Addusers> {
  bool ? isselected = false;
  TextEditingController email = TextEditingController();
  TextEditingController Fullname = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController Willaya = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Groupage = TextEditingController();
  TextEditingController IdOfpulse = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(216, 97, 97, 1),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(

          color: Color.fromARGB(255, 255, 255, 255),borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
             
              children: [
                 Container(
                        height: 40,
                        width: 900,
                        
                       child: Headerwidget(),
                       
                       ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration( color: Color.fromARGB(255, 255, 81, 0),borderRadius: BorderRadius.circular(10)),
                   width: 600,height: 40,
                    child: const Center(child: Text(
                      "Please Be careful  whene enter your data patients",style: TextStyle(color: Colors.white,fontSize: 15,),)
                      ),
                   ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text("Add Patients:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        SizedBox(width: 20,),
                         Container(
                          
                         width: 500,
                         
                           child: Form(
                                                                
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                
                                                                
                                                                   TextFormField(
                                                                    
                                                                    controller: email,
                                                                    autofocus: true,                                    
                                                                     decoration: InputDecoration(
                                                                      labelText: "Email:",
                                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                                      )),),
                                                                      SizedBox(height: 20,),
                                                                
                                                                        TextFormField(
                                                                     obscureText: false,
                                                                  controller: Fullname,
                                                                  decoration: InputDecoration(
                                                                    labelText: "FullName:",
                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                                    )),),
                                                                                                                                    SizedBox(height: 20,),
                         
                                                                         TextFormField(
                                                                     obscureText: false,
                                                                  controller: PhoneNumber,
                                                                  decoration: InputDecoration(
                                                                    labelText: "Phone Number:",
                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                                    )),),
                                                                   const SizedBox(height: 20,),
                           
                                                                         TextFormField(
                                                                     obscureText: false,
                                                                  controller: Willaya,
                                                                  decoration: InputDecoration(
                                                                    labelText: "Wilaya:",
                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                                    )),),
                                                                    
                                                                    const SizedBox(height: 20,),
                                                                     TextFormField(
                                                                     obscureText: true,
                                                                  controller: Password,
                                                                  decoration: InputDecoration(
                                                                    labelText: "Password:",
                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                                    )),),
                                                                   
                                                                    
                                                                    const SizedBox(height: 50,),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                                                  
                                                                  onPressed: (){
                                                                  
                                                                }, child: const Text("Add Now",style: TextStyle(color: Colors.white),)),
                                                                const SizedBox(height: 20,),
                                                                ],
                                                                ),
                                                                ),
                         ),
                         SizedBox(width: 80,),
                                 Container(
                          
                         width: 200,
                         
                           child: Form(
                                                                
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                               TextFormField(
                                                                     obscureText: false,
                                                                  controller: Age,
                                                                  decoration: InputDecoration(
                                                                    labelText: "Age:",
                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                                    )),),
                                                                                                                                    SizedBox(height: 20,),
                         
                                                                    DropdownMenu(dropdownMenuEntries: <DropdownMenuEntry>[
                                                                           DropdownMenuEntry(value: Colors.accents, label: "O+"),
                                                                           DropdownMenuEntry(value: Colors.accents, label: "O-"),
                                                                           DropdownMenuEntry(value: Colors.accents, label: "A-"),
                                                                           DropdownMenuEntry(value: Colors.accents, label: "A+"),
                                                                           DropdownMenuEntry(value: Colors.accents, label: "B+"),
                                                                           DropdownMenuEntry(value: Colors.accents, label: "B-"),
                                                                           DropdownMenuEntry(value: Colors.accents, label: "AB+"),
                                                                           DropdownMenuEntry(value: Colors.accents, label: "AB-"),
                                                                    ]),
                                                                   const SizedBox(height: 20,),
                                                                    Row(children: [  Text("Have You Heart Problems ?",style: TextStyle(fontSize: 15,color: Colors.black,),
                                                                    ),
                                                                    Checkbox(value: isselected, 
                                                                    activeColor: Color.fromRGBO(216, 97, 97, 1),
                                                                    onChanged: (Newbool){
                                                                      setState(() {
                                                                      isselected=Newbool;

                                                                      });
                                                                    })],)
                                                                  
                                                                    
                                                                  
                                                                   
                                                                    
                                                              
                                                                
                                                                ],
                                                                ),
                                                                ),
                         ),
                                       
                       ],
                     ),
                   ),
                  ],)
              ],
            ),
          ),
           
          ),
    );
  }
}