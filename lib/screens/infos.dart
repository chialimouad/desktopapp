import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Infos extends StatefulWidget {
final token;
Infos({Key? key, required this.token});
@override
_InfosState createState() => _InfosState();
}

class _InfosState extends State<Infos> {
final List<String> images = [
'images/imagedoctor1.jpg',
'images/imagedoctor1.jpg',
'images/imagedoctor3.jpg',

];
late SharedPreferences prefs;
late String userid;

TextEditingController controllerconseil = TextEditingController();

late PageController _pageController;
late Timer _timer;
int _currentPage = 0;
    late String docname;

@override
void initState() {
super.initState();
Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
userid = jwtDecodedToken['id'];
docname = jwtDecodedToken['fullname'];

initShared();
_pageController = PageController(initialPage: _currentPage);
_timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
if (_currentPage < images.length - 1) {
_currentPage++;
} else {
_currentPage = 0;
}
_pageController.animateToPage(
_currentPage,
duration: Duration(milliseconds: 300),
curve: Curves.easeInOut,
);
});
}

initShared() async {
prefs = await SharedPreferences.getInstance();
}
insertData() async {
if ( controllerconseil.text.isNotEmpty) {
var regbody = {
"advice": controllerconseil.text,
"docname":docname,
"userId": userid,


};
var res = await http.post(Uri.parse("https://s4db.onrender.com/12/advice"),
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
} 
}else {
AwesomeDialog(
context: context,
dialogType: DialogType.error,
animType: AnimType.bottomSlide,
title: 'Error',
desc: 'Failed to Send user!',
btnOkOnPress: () {},
)..show();
}
}
final ButtonStyle style =
ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20,color: Colors.white),backgroundColor: Color.fromRGBO(0, 52, 102, 1));


@override
void dispose() {
_timer.cancel();
_pageController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: ListView(
children: [Column(
children: [
Padding(
padding: const EdgeInsets.all(8.0),
child: Container(
width: double.maxFinite,
height: 50,
child: Headerwidget()),
),
Padding(
padding: const EdgeInsets.only(top: 18.0),
child: Row(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Container(
height: 300,
width: 800,
decoration: BoxDecoration(color: const Color.fromARGB(112, 255, 255, 255),borderRadius: BorderRadius.circular(20)),
child: PageView.builder(
controller: _pageController,
itemCount: images.length,
itemBuilder: (context, index) {
return Padding(
padding: const EdgeInsets.all(18.0),
child: Center(
child: Stack(
children: [


Container(decoration: BoxDecoration(color: Color.fromARGB(50, 27, 25, 25),borderRadius: BorderRadius.circular(10),image: DecorationImage(image: AssetImage(images[index],

),fit: BoxFit.cover)),)
]
),
),
);
},
onPageChanged: (int index) {
setState(() {
_currentPage = index;
});
},
),
),
],
),
],
),
),
Container(
width: 900,
height: 500,

child: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox(height: 30,),
Text("Advice for ${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day} To Your Patients:",style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal),),
SizedBox(height: 30,),
Form(child: Column(children: [
TextFormField(


  obscureText: false,
  controller: controllerconseil,
  
  maxLines: 5,
  decoration: InputDecoration(
    
    labelText: "Send Advice !",
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
  ),
),
],)
),
SizedBox(height: 30,),
ElevatedButton.icon(
style: style,
onPressed: (){
insertData();
}, icon: Icon(Icons.send,color: Colors.white,), label: Text("Send",style: TextStyle(color: Colors.white),))
],
),
)
],
),]
),
);
}
}
