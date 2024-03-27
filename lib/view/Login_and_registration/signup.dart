import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/firebase_functions.dart';
import 'package:onetheatre/view/Login_and_registration/login.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var formkey = GlobalKey<FormState>();

  var emailctrl = TextEditingController();
  var namectrl = TextEditingController();
  var phonectrl = TextEditingController();

  var passctrl = TextEditingController();
  var cpassctrl = TextEditingController();
  bool showpass = false;
  double cardh = 670;
  double conth = 100;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                height: 670,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: SingleChildScrollView(
                    child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Signup',
                              style: GoogleFonts.salsa(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: namectrl,
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return "Required Field";
                                  } else {
                                    return null;
                                  }
                                },
                                style: GoogleFonts.salsa(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Enter your Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    hintStyle: GoogleFonts.salsa(
                                        color:
                                            Color.fromARGB(110, 255, 255, 255)),
                                    labelText: 'Name',
                                    labelStyle:
                                        GoogleFonts.salsa(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
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
                                        color:
                                            Color.fromARGB(110, 255, 255, 255)),
                                    labelText: 'Email',
                                    labelStyle:
                                        GoogleFonts.salsa(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: phonectrl,
                                validator: (phone) {
                                  if (phone!.length != 10) {
                                    return "Invalid Phone No";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.salsa(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Enter your phone no',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    hintStyle: GoogleFonts.salsa(
                                        color:
                                            Color.fromARGB(110, 255, 255, 255)),
                                    labelText: 'Phone No',
                                    labelStyle:
                                        GoogleFonts.salsa(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
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
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: cpassctrl,
                                validator: (password) {
                                  if (password != passctrl.text) {
                                    return "Wrong password";
                                  } else {
                                    return null;
                                  }
                                },
                                style: GoogleFonts.salsa(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  hintStyle: GoogleFonts.salsa(
                                      color: const Color.fromARGB(
                                          111, 255, 255, 255)),
                                  labelText: 'Confirm Password',
                                  labelStyle:
                                      GoogleFonts.salsa(color: Colors.white),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                var valid = formkey.currentState!.validate();
                                if (valid == true) {
                                  String name = namectrl.text.trim();
                                  String email = emailctrl.text.trim();
                                  String phone = phonectrl.text.trim();
                                  String password = passctrl.text.trim();
                                  FireFunctions()
                                      .registeruser(
                                          name: name,
                                          email: email,
                                          phone: phone,
                                          password: password)
                                      .then((value) {
                                    if (value == null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        value,
                                        style: GoogleFonts.salsa(),
                                      )));
                                    }
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Invalid Details')));
                                }
                              },
                              child: Text(
                                'Signup',
                                style: GoogleFonts.salsa(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 8, 182, 182)),
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(200, 50))),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text(
                                  'Already Have an Account? Signin',
                                  style: GoogleFonts.salsa(color: Colors.white),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SignInButton(Buttons.google,
                                  elevation: 10,
                                  clipBehavior: Clip.antiAlias,
                                  onPressed: () {},
                                  text: "Continue With Google",
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: ((h - cardh) / 2) - (conth * 0.5),
            left: (w * 0.5) - (conth * 0.5),
            child: Container(
              width: 100,
              height: 100,
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
