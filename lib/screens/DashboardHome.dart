import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/compo/Calendar.dart';

import 'package:deskapp/screens/addusers.dart';
import 'package:deskapp/screens/allpatients.dart';
import 'package:deskapp/screens/history.dart';
import 'package:deskapp/screens/homelogin.dart';
import 'package:deskapp/screens/infos.dart';
import 'package:deskapp/screens/logindoc.dart';
import 'package:deskapp/screens/settings.dart';
import 'package:deskapp/screens/stat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
class Dashboar extends StatelessWidget {
  const Dashboar({super.key});

  @override
  Widget build(BuildContext context) {
    return  
        Scaffold(
          body: Container(
            color: Colors.white,
            child: const Row(
              children: [
              Nvbar(),
              
              LeftPath(),
            ],),
          ),
        );
      
    
  }
}

class LeftPath extends StatefulWidget {
  const LeftPath({super.key});

  @override
  State<LeftPath> createState() => _LeftPathState();
}

class _LeftPathState extends State<LeftPath> {
  File? image;
  Future pickimage()async{
   try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
     if(image==null)
      return;
      final imagetomp=File(image.path);
      setState(() {
        this.image=imagetomp;
      });
   }on PlatformException catch(err){
    print(err);
   }
     
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: 280,height: double.infinity,
         decoration: BoxDecoration(
          color: Color.fromRGBO(216, 97, 97, 1),
          borderRadius: BorderRadius.circular(0),
           
          ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Center(
            child: Container(
                     decoration: BoxDecoration(
          color: Color.fromRGBO(216, 97, 97, 1),
          borderRadius: BorderRadius.circular(5),
              // boxShadow: const[
              //     BoxShadow(
              //       offset: const Offset(0,0),
              //       spreadRadius: 0.2,
              //       blurRadius: 0.2,
              //       color: Colors.black
              //     )
              //   ]
          ),
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
                  Container(child: ClipOval(child:       CircleAvatar(
            backgroundColor: Colors.greenAccent[400],
            radius: 50,
            child: image!=null? 
                 Image.file(image!,)
                 :Image.asset('images/doctor.jpg'),//Text
          ),),),
                 Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: IconButton(onPressed: (){
                      pickimage();
                    }, icon: Icon(Icons.add)),
                  )),
                  
                 const Text("Alex Jimmy",style: TextStyle(
                                    decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: 14
                                                 ),
              
                 ),
                  const Text("56",style: TextStyle(
                                    decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: 14
                            ),),
                            SizedBox(height: 30,),
                        Padding(
                        padding:  EdgeInsets.all(0.0),
                        
                       child: Container(
                        
                       
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                           
                                   Container(
                                     width: 50,
                                     height: 50,
                                     decoration: BoxDecoration(  color: Color.fromRGBO(216, 97, 97, 1),
                                     borderRadius: BorderRadius.circular(10)
                                     
                                   ),
                                   child: const Center(child: Text("Oran 31000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                   ),
                                   Container(
                                     width: 70,
                                     height: 70,
                                     decoration: BoxDecoration(  color: Color.fromRGBO(216, 97, 97, 1),
                                     borderRadius: BorderRadius.circular(10)
                                     
                                   ),
                                   child: const  Center(child: Text("Medical Center",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                   ),
                                   Container(
                                     width: 50,
                                     height: 50,
                                     decoration: BoxDecoration(  color: Color.fromRGBO(255, 255, 255, 1),
                                     borderRadius: BorderRadius.circular(10)
                                   ),
                                     child: IconButton(
                                       onPressed: (){}, icon:  Icon (Icons.logout) ,iconSize: 30,color: const Color.fromARGB(255, 0, 0, 0),  
                                       
                                     ),
                                     ) ,  
                                      
                                     ],
                                   
                                     ),
                       ),
              
              
                ),
                SizedBox(height: 30,),
                    Center(child: Container(
                      child: Column(
                      children: [
                        Calendarwidget(),

                      ],
                    ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Image.asset("images/fb.png",width: 30,height: 30,),
                        Image.asset("images/insta.png",width: 30,height: 30,),
                        Image.asset("images/x.png",width: 30,height: 30,),
                        ],),
                    )
                 ],
                 
                 ),
            ),
          ),
        ),
        ),
    );
  }
}


class Nvbar extends StatefulWidget {
  const Nvbar({super.key});

  @override
  State<Nvbar> createState() => _NvbarState();
}

class _NvbarState extends State<Nvbar> {
 final List<Widget> screens =[HomeLogin(),Allpatient(),Addusers(),History(),Infos(),Stat(),Settings()];
  int selected =0;
  @override
  Widget build(BuildContext context) {
    return 
       Expanded(
       
        child: Container(
          color: const Color.fromRGBO(216, 97, 97, 1),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Center(
              child: Row(
                children: [
                NavigationRail(
                  selectedIconTheme: IconThemeData(color: Colors.white),
                  unselectedIconTheme: IconThemeData(color: Colors.black),
                  selectedLabelTextStyle: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 13),
                indicatorColor: Color.fromRGBO(255, 255, 255, 1),    
              labelType: NavigationRailLabelType.all,
                 minWidth: 50,
                 
                  groupAlignment: 0.08,
               
                  useIndicator: false,
                    backgroundColor: Color.fromRGBO(216, 97, 97, 1),
                  onDestinationSelected: (int index) => setState(() {
                    selected=index;
                  }) ,
                  destinations:const [
                  NavigationRailDestination(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.home,),
                    ),label: Text("Home")),
                   NavigationRailDestination(
                    icon:
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.person),
                    ),
                    label: Text("Patients")),
                    NavigationRailDestination(icon: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.add,),
                    ), label: Text("Add")),
                    NavigationRailDestination(icon: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.history),
                    ), label: Text("History")),
                    NavigationRailDestination(icon: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.info),
                    ), label: Text("Infos")),
                    NavigationRailDestination(icon: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.settings_accessibility_rounded),
                    ), label: Text("Settings")),
                ], selectedIndex: selected),
                 Expanded(child: Center(child: screens[selected])),
                
              
              ],),
            ),
          ),
        ),
      );
    
  }
}
