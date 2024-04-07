import 'dart:convert';
import 'dart:ui';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/screens/allpatients.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

enum GrpLabel {
  O('0+'),
  oo('O-'),
  ab('AB+'),
  abab('AB-'),
  A('A-'),
  aa('A+'),
   bB('B-'),
  B('B+');
  
  const GrpLabel(this.label);
  final String label;
}
enum Gender {
  female('Male'),
  male('Female');

  
  const Gender(this.label);
  final String label;
}
enum Maladie {
    ml0('  None'),
  ml1('Hypertension artérielle'),
  ml2('Maladie coronarienne'),
  ml3('Infarctus du myocarde (crise cardiaque) '),
  ml4('Cardiomyopathie '),
  ml5('  Valvulopathies cardiaques '),

  ml6('Insuffisance cardiaque');
  const Maladie(this.label);
  final String label;
}
class Addusers extends StatefulWidget {
  final token;
  Addusers({Key? key, required this.token});

  @override
  State<Addusers> createState() => _AddusersState();
}

class _AddusersState extends State<Addusers> {
  GrpLabel? grp;Gender? gndr;Maladie?mlde;
  bool? isselected = false;
  bool? isemail = false;
  bool? isalphapulse = false;
  bool? isalpha = false;
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'DZA '); 
  TextEditingController email = TextEditingController();
  TextEditingController Fullname = TextEditingController();
  TextEditingController Willaya = TextEditingController();
  TextEditingController Password = TextEditingController();
    TextEditingController mldcontroller = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Groupage = TextEditingController();
    TextEditingController Gnde = TextEditingController();
    TextEditingController mlre = TextEditingController();

  TextEditingController IdOfpulse = TextEditingController();
    TextEditingController moredata = TextEditingController();

  late SharedPreferences prefs;
  late String userid;
  final formKey = GlobalKey<FormState>();
    final formKey1 = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userid = jwtDecodedToken['id'];
    initShared();
  }

  initShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  insertData() async {
    if (email.text.isNotEmpty && Password.text.isNotEmpty && Fullname.text.isNotEmpty && Willaya.text.isNotEmpty) {
      var regbody = {
        "email": email.text,
        "fullname": Fullname.text,
        "phonenumber": phoneNumber.phoneNumber,
        "willaya": Willaya.text,
        "password": Password.text,
        "Age": Age.text,
        "Specialite": isselected.toString(),
        "Grp": grp!.label.toString(),
        "idpulse": IdOfpulse.text,
        "userId": userid,
        "Gender":gndr!.label.toString(),
        "mld":mlde!.label.toString(),
        "moredata":moredata.text,
      };
      var res = await http.post(Uri.parse("https://s4db.onrender.com/12/registeruser"),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regbody)
      );
      var resjson = jsonDecode(res.body);
      print(res.body);
      if (resjson['status']) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'User added successfully!',
          btnOkOnPress: () {},
        )..show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Error',
          desc: 'Failed to add user!',
          btnOkOnPress: () {},
        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.949),
      body: Expanded(
        child: Center(
          child: ListView(
            children: [
              Container(
                height: double.maxFinite,
width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    children: [
                      WindowTitleBarBox(
                        child: Column(
                          children: [
                            Expanded(
                              child: MoveWindow(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: double.maxFinite,
                        child: Headerwidget(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 81, 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 600,
                          height: 40,
                          child: const Center(child: Text(
                            "Please Be careful when entering patient data",style: TextStyle(color: Colors.white,fontSize: 15,),)
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text("Add Patients:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 20,),
                                Container(
                                  width: 350,
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        
                                        TextFormField(
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return "Please insert valid email";
                                            }
                                          },
                                          cursorColor: isemail! ? Colors.green : Colors.red,
                                          controller: email,
                                          autofocus: true,
                                          onChanged: (val){
                                            setState(() {
                                              isemail = isEmail(val);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Email of patient",
                                            labelText: "Email:",
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        TextFormField(
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              if(value!.length <= 6){
                                                return "Please Must be Less than 16 Letters";
                                              }
                                            }
                                          },
                                          cursorColor: isemail! ? Colors.green : Colors.red,
                                          obscureText: false,
                                          controller: Fullname,
                                          onChanged: (val){
                                            setState(() {
                                              isemail = isAlpha(val);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: "FullName:",
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                    
                                        SizedBox(height: 10,),
                                        TextFormField(
                                          onChanged: (val){
                                            setState(() {
                                              isalphapulse = isAlphanumeric(val);
                                            });
                                          },
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return "complete the field";
                                            }
                                          },
                                          obscureText: false,
                                          controller: IdOfpulse,
                                          decoration: InputDecoration(
                                            labelText: "Id Of pulse:",
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        InternationalPhoneNumberInput( 
                                          onInputChanged: (PhoneNumber number) { 
                                            phoneNumber = number; 
                                          }, 
                                          selectorConfig: SelectorConfig( 
                                            selectorType: PhoneInputSelectorType.DIALOG, 
                                          ), 
                                          ignoreBlank: false, 
                                          autoValidateMode: AutovalidateMode.onUserInteraction, 
                                          selectorTextStyle: TextStyle(color: Colors.black), 
                                          initialValue: phoneNumber, 
                                          textFieldController: TextEditingController(), 
                                          inputDecoration: InputDecoration( 
                                            labelText: 'Phone Number', 
                                            border: OutlineInputBorder(), 
                                          ), 
                                          formatInput: false, 
                                        ),
                                        SizedBox(height: 30,),
                                                   TextFormField(
                                        
                                        
                                          obscureText: false,
                                          controller: moredata,
                                         
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            
                                            labelText: "Add more Details:",
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                           
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Container(
                                  width: 350,
                                  child: Form(
                                    key: formKey1,                          
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                            TextFormField(
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return "Please Complete";
                                            }
                                          },
                                          cursorColor: isemail! ? Colors.green : Colors.red,
                                          obscureText: false,
                                          controller: Willaya,
                                          decoration: InputDecoration(
                                            labelText: "Wilaya:",
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        TextFormField(
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return "Password field null";
                                            }
                                          },
                                          cursorColor: isemail! ? Colors.green : Colors.red,
                                          obscureText: true,
                                          controller: Password,
                                          decoration: InputDecoration(
                                            labelText: "Password:",
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              child: TextFormField(
                                                validator: (value){
                                                  if(value == null || value.isEmpty){
                                                    return "complete the field";
                                                  }
                                                },
                                                obscureText: false,
                                                controller: Age,
                                                decoration: InputDecoration(
                                                  labelText: "Age:",
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                ),
                                              ),
                                            ),
                                                    SizedBox(width: 20,),
                                        DropdownMenu<GrpLabel>(
                                          initialSelection: GrpLabel.O,
                                          controller: Groupage,
                                          requestFocusOnTap: true,
                                          label: const Text("Groupage"),
                                          onSelected: (GrpLabel? grp1){
                                            setState(() {
                                              grp = grp1;
                                            });
                                          },
                                          width: 100,
                                          dropdownMenuEntries: GrpLabel.values.map<DropdownMenuEntry<GrpLabel>>(
                                            (GrpLabel e){
                                              return DropdownMenuEntry<GrpLabel>(value: e,label: e.label, enabled: e.label != '',
                                                style: MenuItemButton.styleFrom(
                                                  foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                                                ),
                                              );
                                            }
                                          ).toList(),
                                        ),
                                        SizedBox(width: 20,),
                                                 DropdownMenu<Gender>(
                                          initialSelection: Gender.male,
                                          controller: Gnde,
                                          requestFocusOnTap: true,
                                          label: const Text("Gender"),
                                          onSelected: (Gender? gnd1){
                                            setState(() {
                                              gndr = gnd1;
                                            });
                                          },
                                          width: 110,
                                          dropdownMenuEntries: Gender.values.map<DropdownMenuEntry<Gender>>(
                                            (Gender e){
                                              return DropdownMenuEntry<Gender>(value: e,label: e.label, enabled: e.label != '',
                                                style: MenuItemButton.styleFrom(
                                                  foregroundColor: Color.fromRGBO(0, 0, 0, 1),
                                                ),
                                              );
                                            }
                                          ).toList(),
                                        ),
                                        
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                             Text("Have You Heart Problems ?", style: TextStyle(fontSize: 15,color: Colors.black)),
                                            Checkbox(
                                              value: isselected, 
                                              activeColor: Color.fromRGBO(0, 0, 0, 1),
                                              onChanged: (Newbool){
                                                setState(() {
                                                  isselected=Newbool;
                                                });
                                              }
                                            ),
                                            SizedBox(height: 40,),
                                                                DropdownMenu<Maladie>(
                                          initialSelection: Maladie.ml1,
                                          controller: mlre,
                                          requestFocusOnTap: true,
                                          label: const Text("Mladies"),
                                          onSelected: (Maladie? mld){
                                            setState(() {
                                              mlde = mld;
                                            });
                                          },
                                          width: 300,
                                          dropdownMenuEntries: Maladie.values.map<DropdownMenuEntry<Maladie>>(
                                            (Maladie e){
                                              return DropdownMenuEntry<Maladie>(value: e,label: e.label, enabled: e.label != '',
                                                style: MenuItemButton.styleFrom(
                                                  foregroundColor: Color.fromRGBO(0, 0, 0, 1),
                                                ),
                                              );
                                            }
                                          ).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,   
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(200, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: (){
                                  insertData();
                                }, 
                                child: const Text("Add Patient Now",style: TextStyle(color: Colors.white,))
                              ),
                              SizedBox(height: 200,)
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
      ),
    );
  }
}
