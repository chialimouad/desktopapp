import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/screens/DashboardHome.dart';
import 'package:deskapp/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class LoginDoc extends StatelessWidget {
  const LoginDoc({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 768) {
            // For desktop and tablet
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Left(),
                ),
                Expanded(
                  flex: 3,
                  child: Right(),
                ),
              ],
            );
          } else {
            // For phone
            return Right();
          }
        },
      ),
    );
  }
}

class Left extends StatelessWidget {
  const Left({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("images/logomouad.png", width: 200, height: 200),
        ],
      ),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromRGBO(4, 62, 117, 0.95), Color.fromRGBO(27, 98, 165, 0.949)],
          stops: [0.0, 1.0],
        ),
        image: DecorationImage(
          image: AssetImage("images/doc.png"),
        ),
      ),
    );
  }
}

class Right extends StatefulWidget {
  const Right({Key? key});

  @override
  State<Right> createState() => _RightState();
}

class _RightState extends State<Right> {
  late SharedPreferences prefs;
  bool isactive = false;
  bool? isemail = false;
  final key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    initshared();
  }

  initshared() async {
    prefs = await SharedPreferences.getInstance();
  }

Future<void> loginuser() async {
  if (validateInputs()) {
    try {
      setState(() {
        isactive = true;
      });

      var regbody = {
        "email": email.text,
        "password": pass.text,
      };

      var res = await http.post(
        Uri.parse("https://s4db.onrender.com/12/logindoc"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regbody),
      );

      var resjson = jsonDecode(res.body);

      if (resjson['status']) {
        var mytoken = resjson['token'];
        prefs.setString('token', mytoken);
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => Dashboar(token: mytoken))),
        );
        showSuccessDialog();
      } else {
        showErrorDialog();
      }

    } catch (e) {
      showErrorDialog();
    } finally {
      setState(() {
        isactive = false;
      });
    }
  }
}

bool validateInputs() {
  if (email.text.isEmpty || pass.text.isEmpty) {
    showErrorDialog();
    return false;
  }
  return true;
}

  void showSuccessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'Success',
      desc: 'Registration successful!',
      btnOkOnPress: () {},
    )..show();
  }

  void showErrorDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Error',
      desc: 'Registration failed!',
      btnOkColor: Color.fromARGB(0, 255, 15, 15),
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(
                child: MoveWindow(),
              ),
              const Windows(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Container(
                width: 400,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [BoxShadow(blurRadius: 1)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "WELCOME",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Dr.",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: key,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please insert valid email";
                              }
                            },
                            cursorColor: isemail! ? Colors.green : Colors.red,
                            controller: email,
                            autofocus: true,
                            onChanged: (val) {
                              setState(() {
                                isemail = isEmail(val);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Email:",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            controller: pass,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please insert password";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Password:",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () {
                              if (key.currentState?.validate() ?? false) {
                                loginuser();
                              }
                            },
                            child: isactive
                                ? SizedBox(
                                    width: 120,
                                    height: 80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                        SizedBox(width: 10),
                                        Text("Submitting", style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  )
                                : Text("Login Dr", style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 20),
                          const Text("Optimal Health and Well-being"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

var window = WindowButtonColors(
  mouseDown: Colors.white,
  mouseOver: Colors.white,
  iconMouseDown: Colors.white10,
  iconNormal: Colors.black,
);

class Windows extends StatelessWidget {
  const Windows({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: window),
        MaximizeWindowButton(colors: window),
        CloseWindowButton(colors: window),
      ],
    );
  }
}
