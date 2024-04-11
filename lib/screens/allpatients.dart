import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/headerwidget2.dart';

import 'package:deskapp/screens/test2.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class Allpatient extends StatefulWidget {
final String token;

const Allpatient({required this.token, Key? key}) : super(key: key);

@override
State<Allpatient> createState() => _AllpatientState();
}

class _AllpatientState extends State<Allpatient> {
late StreamController<List> _streamController;
final formKey = GlobalKey<FormState>();
PhoneNumber phoneNumber = PhoneNumber(isoCode: 'DZA '); 
TextEditingController email = TextEditingController();
TextEditingController Fullname = TextEditingController();
TextEditingController Willaya = TextEditingController();
TextEditingController Password = TextEditingController();
TextEditingController mldcontroller = TextEditingController();
TextEditingController IdOfpulse = TextEditingController();
late SharedPreferences prefs;
late String userId;
late String docname;

initShared() async {
prefs = await SharedPreferences.getInstance();
}

updatedata(String id) async {


var regbody = {
"email": email.text,
"fullname": Fullname.text,
"phonenumber": phoneNumber.phoneNumber,
"willaya": Willaya.text,
"password": Password.text,
"idpulse": IdOfpulse.text,
"id":id

};
var res = await http.post(Uri.parse("https://s4db.onrender.com/12/update"),
headers: {"Content-Type":"application/json"},
body: jsonEncode(regbody)
);
var resjson = jsonDecode(res.body);
print(res.body);
if (resjson['status']) {

getuser(userId)   ;    
AwesomeDialog(
context: context,
dialogType: DialogType.success,
animType: AnimType.bottomSlide,
title: 'Success',
desc: 'User updated successfully!',
btnOkOnPress: () {},
)..show();
} else {
AwesomeDialog(
context: context,
dialogType: DialogType.error,
animType: AnimType.bottomSlide,
title: 'Error',
desc: 'Failed to update user!',
btnOkOnPress: () {},
)..show();
}

}

bool? isselected = false;
bool? isemail = false;
bool? isalphapulse = false;
bool? isalpha = false;
@override
void initState() {
super.initState();
_streamController = StreamController<List>.broadcast();
final jwtDecodedToken = JwtDecoder.decode(widget.token);
userId = jwtDecodedToken['id'];
getuser(userId);
print(userId);

}

@override
void dispose() {
_streamController.close();
super.dispose();
}

void getuser(String userId) async {
try {
final regbody = {
"userId": userId,
};
final response = await http.post(
Uri.parse("https://s4db.onrender.com/12/getuser"),
headers: {"Content-Type": "application/json"},
body: jsonEncode(regbody),
);
final newtoken = jsonDecode(response.body);
_streamController.sink.add(newtoken['success']);
} catch (err) {

}
}

void deleteuser(String id) async {
final regbody = {
"id": id,
};
final res = await http.post(
Uri.parse("https://s4db.onrender.com/12/delete"),
headers: {"Content-Type": "application/json"},
body: jsonEncode(regbody),
);
final neww = jsonDecode(res.body);
if (neww['status']) {
getuser(userId);
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: Column(
children: [
Container(
height: 70,
width: double.maxFinite,
color: Colors.white,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Headerwidget(),
)),

Expanded(
child: Container(
height: double.maxFinite,
width: double.maxFinite,
color: Colors.white,
child: StreamBuilder<List>(
stream: _streamController.stream,
builder: (context, snapshot) {
if (snapshot.hasData) {
final List items = snapshot.data as List;
return  items==null?Image.asset('images/nouser.jpg'): DataTable(
columns: [
DataColumn(label: Text('Full Name')),
DataColumn(label: Text('Age')),
DataColumn(label: Text('Willaya')),
DataColumn(label: Text('Phone Number')),
DataColumn(label: Text('Status')),
DataColumn(label: Text('Bpm')),
DataColumn(label: Text('Actions')),
],
rows: items.map((item) {
return DataRow(cells: [
DataCell(Text('${item['fullname']}')),
DataCell(Text('${item['Age']}')),
DataCell(Text('${item['willaya']}')),
DataCell(Text('${item['phonenumber']}')),
DataCell(CircleAvatar(radius: 4,backgroundColor: Colors.green,)),
DataCell(Text('88')),

DataCell(Row(
children: [
IconButton(
onPressed: () {
deleteuser('${item['_id']}');
},
icon: Icon(Icons.delete, color: Colors.red),
),
IconButton(
onPressed: () {
showMyDialog('${item['fullname']}', '${item['Age']}', '${item['willaya']}', '${item['phonenumber']}','${item['docname']}');
},
icon: Icon(Icons.more_horiz, color: Colors.black),
),
TextButton(onPressed: (){
showupdate('${item['_id']}','${item['fullname']}', '${item['email']}', '${item['willaya']}', '${item['phonenumber']}','${item['idpulse']}');

},  child:Text("Update",style: TextStyle(color: Colors.black,fontSize: 16,),)),
],
)),
]);
}).toList(),
);
} else {
return 
Center(
child: CircularProgressIndicator(),
);

}
},
),
),
),
],
),
);
}


Future<void> showMyDialog(String name, String age, String willaya, String Number,String docname) async {
return showDialog<void>(
context: context,
barrierDismissible: false,
builder: (BuildContext context) {
return Dialog.fullscreen(
child: ListView(
children: [
Column(
children: [
WindowTitleBarBox(
child: Column(
children: [
Expanded(child: MoveWindow()),
],
),
),
Container(
height: 40,
width: double.maxFinite,
child:
Headerwidget2(),



),
SizedBox(width: 40,),
Row(
crossAxisAlignment: CrossAxisAlignment.end,
mainAxisAlignment: MainAxisAlignment.end,
children: [

],
),

Container(
color: Colors.white10,
child: Column(
children: [
Text(" The name of your Patient :$name"),
Text(" The age of your Patient :$age"),
Text(" The willaya of your Patient :$willaya"),
Text(" The Phone Number  of your Patient :+$Number"),
Text(" The Name of Doctor :$docname"),

],
),
),
Center(
child: Container(
width: 500,
height: 500,
child: EcgChart(),
),
),
Center(
child: Container(
width: 500,
height: 500,
child: Container(),
),
),
],
),
],
),
);
},
);
}





Future<void> showupdate(String id,String Email, String fullname, String willaya, String phone,String idpulse) async {
return showDialog<void>(
context: context,
barrierDismissible: false,
builder: (BuildContext context) {
return Dialog.fullscreen(
child: ListView(
children: [
Column(
children: [

Container(
width: double.maxFinite,
height: 60,
child: Headerwidget2()),
Container(
width: 500,
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
SizedBox(height: 20,),
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
SizedBox(height: 50,),
ElevatedButton(onPressed: (){
  updatedata(id);
  }, child: Text("Update"))
],
),
),
),





],
),
],
),
);
},
);
}
}
