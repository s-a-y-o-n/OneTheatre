import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/firebase_functions.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Login_and_registration/signup.dart';
import 'package:onetheatre/view/Pages/navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formkey = GlobalKey<FormState>();

  var emailctrl = TextEditingController();

  var passctrl = TextEditingController();
  bool showpass = false;
  double cardh = 550;
  double conth = 100;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    void login() async {
      showDialog(
          context: context,
          builder: (context) => Center(
                child: CircularProgressIndicator(),
              ));
      String email = emailctrl.text.trim();
      String password = passctrl.text.trim();
      FireFunctions().login(email: email, password: password).then((value) {
        if (value == null) {
          Navigator.pop(context);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BotNavbar()));
        } else {
          Navigator.pop(context);
          showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Nice Try'),
                  backgroundColor: Color.fromARGB(255, 2, 118, 118),
                  titleTextStyle: GoogleFonts.salsa(fontSize: 20),
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 60,
                  ),
                  iconColor: Colors.red,
                  actions: [
                    TextButton(
                        onPressed: () {
                          passctrl.text = '';
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: GoogleFonts.salsa(color: Constants.seccolor),
                        ))
                  ],
                );
              });
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,

      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
            Colors.white,
            Color.fromARGB(255, 16, 97, 97),
          ], radius: 1)),
          child: Center(
            child: Card(
              surfaceTintColor: Color.fromARGB(255, 8, 182, 182),
              color: Colors.transparent,
              elevation: 15,
              child: Container(
                width: 370,
                height: cardh,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.salsa(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            controller: emailctrl,
                            validator: (email) {
                              if (email!.isEmpty || !email.contains("@")) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            style: GoogleFonts.salsa(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                hintStyle: GoogleFonts.salsa(
                                    color: Color.fromARGB(110, 255, 255, 255)),
                                labelText: 'Email',
                                labelStyle:
                                    GoogleFonts.salsa(color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            controller: passctrl,
                            validator: (password) {
                              if (password!.length < 6) {
                                return "Invalid password";
                              } else {
                                return null;
                              }
                            },
                            obscureText: !showpass,
                            style: GoogleFonts.salsa(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                hintStyle: GoogleFonts.salsa(
                                    color: const Color.fromARGB(
                                        111, 255, 255, 255)),
                                labelText: 'Password',
                                labelStyle:
                                    GoogleFonts.salsa(color: Colors.white),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showpass
                                            ? showpass = false
                                            : showpass = true;
                                      });
                                    },
                                    icon: (showpass == true)
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                          ))),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            var valid = formkey.currentState!.validate();
                            if (valid) {
                              login();
                            }
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.salsa(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Constants.primarycolor),
                              minimumSize:
                                  MaterialStatePropertyAll(Size(200, 50))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));
                                },
                                child: Text(
                                  'Create Account',
                                  style: GoogleFonts.salsa(color: Colors.white),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.salsa(color: Colors.white),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: SignInButton(Buttons.google,
                                elevation: 10, clipBehavior: Clip.antiAlias,
                                onPressed: () async {
                              UserCredential? userCredential =
                                  await FireFunctions().signinWithGoogle();
                              String? uid = userCredential?.user?.uid;
                              bool isExist =
                                  await FireFunctions().isExistingUser(uid);
                              if (isExist == false) {
                                FireFunctions().addToUser(userCredential?.user);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BotNavbar()));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BotNavbar()));
                              }
                            },
                                text: "Continue With Google",
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))))
                      ],
                    )),
              ),
            ),
          ),
        ),
        Positioned(
            top: ((h - cardh) / 2) - (conth * 0.5),
            left: (w * 0.5) - (conth * 0.5),
            child: Container(
              width: conth,
              height: conth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(209, 1, 47, 47)),
              child: ImageIcon(
                AssetImage("assets/images/logo.png"),
                size: 100,
                color: Colors.white70,
              ),
            ))
      ]),
    );
  }
}
