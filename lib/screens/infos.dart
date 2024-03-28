import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
class Infos extends StatefulWidget {
  final token;
  const Infos({super.key, this.token});

  @override
  State<Infos> createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  late String email;
@override
void initState() {
// TODO: implement initState
super.initState();
Map<String,dynamic> jwtDecodedToken =JwtDecoder.decode(widget.token);
email=jwtDecodedToken['email'];


}
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
        
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))),
        child: Text(email),
        ),
  );
        }
}