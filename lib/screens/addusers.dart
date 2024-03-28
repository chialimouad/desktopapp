import 'dart:ui';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
    import 'package:flutter/cupertino.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter/widgets.dart';
    import 'package:intl_phone_number_input/intl_phone_number_input.dart';
    import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
enum GrpLabel {
  O('0+',),
  oo('O-',),
  ab('AB+',),
  abab('AB-',),
  B('B+',);
  

  const GrpLabel(this.label,);
  final String label;

}
    class Addusers extends StatefulWidget {
      final token;
     Addusers({super.key, required this.token});

    @override
    State<Addusers> createState() => _AddusersState();
    }

    class _AddusersState extends State<Addusers> {
      GrpLabel? grp;
    bool ? isselected = false;
    bool? isemail =false;
    bool? isalphapulse=false;
    bool? isalpha=false;
    PhoneNumber phoneNumber = PhoneNumber(isoCode: 'DZ '); 
    TextEditingController email = TextEditingController();
    TextEditingController Fullname = TextEditingController();
    TextEditingController Willaya = TextEditingController();
    TextEditingController Password = TextEditingController();
    TextEditingController Age = TextEditingController();
    TextEditingController Groupage = TextEditingController();
    TextEditingController IdOfpulse = TextEditingController();
    
        TextEditingController emailconfirm = TextEditingController();

    final formKey = GlobalKey<FormState>();
    final formKey1 = GlobalKey<FormState>();
    late SharedPreferences prefs;
    late dynamic userid;

    @override
    void initState(){
      super.initState();
      Map<String,dynamic> jwtDecodedToken =JwtDecoder.decode(widget.token);
    userid=jwtDecodedToken['userId'];
      initshared();
    }
    initshared()async{
      prefs =await SharedPreferences.getInstance();
    }
 
     insertdata()async {
        
      var res=await http.post(Uri.parse("https://s4db.onrender.com/12/register"),body: {
         "email":email.text,
         "fullname":Fullname.text,
         "phonenumber":phoneNumber.phoneNumber,
         "willaya":Willaya.text,
         "password":Password.text,
         "Age":Age.text,
         "maladie":isselected.toString(),
         //"Grp":grp!.label.toString(),
         "idpulse":IdOfpulse.text,
         
      });

      if(res.statusCode==200){

              showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('kayen'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
         
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
                           onPressed: () => Navigator.pop(context, 'OK'),

              child: const Text('OK'),
            ),
          ],
        ),
      );
      
      }else{
              showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('mkanch'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      }

     }


    @override
    Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color.fromRGBO(216, 97, 97, 1),
    body: Expanded(
      child: Center(
        child: ListView(
          children: [
            Container(
            
         
          decoration: BoxDecoration(
          
          color: Color.fromARGB(255, 255, 255, 255),borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
          ),
          child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
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
              key: formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            
            
            TextFormField(
            validator: (value){
            if(value==null || value.isEmpty){
            return"please insert valid email";
            }
            } ,
            cursorColor: isemail!? Colors.green: Colors.red,
            controller: email,
            autofocus: true,     
            onChanged: (val){
            setState(() {
            isemail=isEmail(val);
            });
            },                               
            decoration: InputDecoration(
            labelText: "Email:",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
            )),),
            SizedBox(height: 20,),
                        
            TextFormField(
            validator: (value){
            if(value==null || value.isEmpty){
            return"please insert valid email";
            }
            } ,
            cursorColor: isemail!? Colors.green: Colors.red,
            controller: emailconfirm,
            autofocus: true,     
            onChanged: (val){
            setState(() {
            isemail=isEmail(val);
            });
            },                               
            decoration: InputDecoration(
            labelText: "Emailconfirme:",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
            )),),
            TextFormField(
            validator: (value){
            if(value==null || value.isEmpty){
            if(value!.length<=6)
            return"Please Must be Less than 16 Letters";
            }
            } ,
            cursorColor: isemail!? Colors.green: Colors.red,
            obscureText: false,
            controller: Fullname,
            onChanged: (val){
            setState(() {
            isemail=isAlpha(val);
            });
            },
            decoration: InputDecoration(
            labelText: "FullName:",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
            )),),
                     
            
            const SizedBox(height: 10,),
            
            TextFormField(
            validator: (value){
            if(value==null || value.isEmpty){
            
            Text("Please Complete");
            }
            } ,
            cursorColor: isemail!? Colors.green: Colors.red,
            obscureText: false,
            controller: Willaya,
            decoration: InputDecoration(
            labelText: "Wilaya:",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
            )),),
            
            const SizedBox(height: 20,),
            TextFormField(
            validator: (value){
            if(value==null || value.isEmpty){
              return"Password field null";
             }
            } ,
            cursorColor: isemail!? Colors.green: Colors.red,
            obscureText: true,
            controller: Password,
            decoration: InputDecoration(
            labelText: "Password:",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
            )),),
            
            
            const SizedBox(height: 10,),
                  TextFormField(
               onChanged: (val){
            setState(() {
            isalphapulse=isAlphanumeric(val);
            });
            },  
            validator: (value){
             
            if(value==null || value.isEmpty){
                   return"complete the field"  ; 
                    }
            } ,
            obscureText: false,
            controller: IdOfpulse,
            decoration: InputDecoration(
            labelText: "Id Of pulse:",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
            )),),
            const SizedBox(height: 10,),
                 InternationalPhoneNumberInput( 
            onInputChanged: (PhoneNumber number) { 
            phoneNumber = number; 
            }, 
            
            selectorConfig: SelectorConfig( 
            selectorType: PhoneInputSelectorType.DIALOG, 
            ), 
            ignoreBlank: false, 
            // Auto-validation mode 
            autoValidateMode: AutovalidateMode.onUserInteraction, 
            // Style for the country selector 
            selectorTextStyle: TextStyle(color: Colors.black), 
            // Initial value for the phone number input 
            initialValue: phoneNumber, 
            // Controller for the text field 
            textFieldController: TextEditingController(), 
            // Decoration for the input field 
            inputDecoration: InputDecoration( 
            labelText: 'Phone Number', 
            border: OutlineInputBorder(), 
            ), 
            formatInput: false, 
            ),
             const SizedBox(height: 30,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [  Text("Have You Heart Problems ?",style: TextStyle(fontSize: 15,color: Colors.black,),
            ),
            Checkbox(
            value: isselected, 
            activeColor: Color.fromRGBO(216, 97, 97, 1),
            onChanged: (Newbool){
            setState(() {
            isselected=Newbool;
            
            });
            }),
            
            
            ],),
            ],
            ),
            ),
            ),
                     
            Container(
            
            width: 100,
            
            child: Form(
            key: formKey1,                          
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Container(
            width: 80,
            child: TextFormField(
            validator: (value){
             
            if(value==null || value.isEmpty){
                   return"complete the field"  ; 
                    }
            } ,
            obscureText: false,
            controller: Age,
            decoration: InputDecoration(
            labelText: "Age:",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
            )),),
            
            ),
            SizedBox(height: 20,),
            
             DropdownMenu<GrpLabel>(
              initialSelection: GrpLabel.O,
              controller: Groupage,
              requestFocusOnTap: true,
              label: const Text("Groupage"),
              onSelected: (GrpLabel? grp1){
                setState(() {
                  grp=grp1;
                });
              },
            width: 80,
            
            dropdownMenuEntries: GrpLabel.values.map<DropdownMenuEntry<GrpLabel>>(
              (GrpLabel e){
                return DropdownMenuEntry<GrpLabel>(value: e,label: e.label, enabled: e.label != 'Grey',
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Color.fromRGBO(216, 97, 97, 1),
                                ),);
                
              }
            ).toList(),
            ),
            const SizedBox(height: 20,),
                    
            
            
            
            
            
            
                    
            ],
            ),
            ),
            ),
            
            ],
            ),
          
          ),
          Row(
        
        crossAxisAlignment: CrossAxisAlignment.start,   
        mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(200, 40),
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // button's shape
            ),
            backgroundColor: Colors.redAccent,),
                
          onPressed: (){
             insertdata();
        
           if (formKey1.currentState?.validate() ?? false) {
          
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data Success '),backgroundColor: Colors.green,),
          );
          }
          if (formKey.currentState?.validate() ?? false) {
          
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data'),backgroundColor: Colors.green,),
          );
          }
          if (formKey.currentState?.validate() ?? false) { 
          print('Phone number: ${phoneNumber.phoneNumber}'); 
          print('ISO code: ${phoneNumber.isoCode}'); 
            } 
          }, child: const Text("Add Patient Now",style: TextStyle(color: Colors.white,),)),
          SizedBox(height: 200,)
          ],
          ),
          ],)
          ],
          ),
          ),
          
          ),],
        ),
      ),
    ),
    );
    }
    }