import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/view/Login_and_registration/login.dart';

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
  bool showpass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1695131022320-c42cd294863f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDM2fGlVSXNuVnRqQjBZfHxlbnwwfHx8fHw%3D"),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'One',
                        style: GoogleFonts.salsa(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))),
                    TextSpan(
                        text: 'Theatre',
                        style: GoogleFonts.salsa(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 8, 182, 182),
                                fontSize: 24,
                                fontWeight: FontWeight.bold)))
                  ])),
                ),
                Center(
                  child: Card(
                    surfaceTintColor: Color.fromARGB(157, 26, 25, 25),
                    color: Color.fromARGB(222, 23, 23, 23),
                    elevation: 15,
                    child: Container(
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
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
                                          color: Color.fromARGB(
                                              110, 255, 255, 255)),
                                      labelText: 'Name',
                                      labelStyle: GoogleFonts.salsa(
                                          color: Colors.white)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: emailctrl,
                                  validator: (email) {
                                    if (email!.isEmpty ||
                                        !email.contains("@")) {
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
                                          color: Color.fromARGB(
                                              110, 255, 255, 255)),
                                      labelText: 'Email',
                                      labelStyle: GoogleFonts.salsa(
                                          color: Colors.white)),
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
                                          color: Color.fromARGB(
                                              110, 255, 255, 255)),
                                      labelText: 'Phone No',
                                      labelStyle: GoogleFonts.salsa(
                                          color: Colors.white)),
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
                                      labelStyle: GoogleFonts.salsa(
                                          color: Colors.white),
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
                                    minimumSize: MaterialStatePropertyAll(
                                        Size(200, 50))),
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
                                    style:
                                        GoogleFonts.salsa(color: Colors.white),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        "assets/images/google-icon.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        'Continue with google',
                                        style: GoogleFonts.salsa(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      maximumSize: MaterialStatePropertyAll(
                                          Size(250, 40))),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
