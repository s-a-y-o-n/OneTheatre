import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Pages/profile.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  static final formkey = GlobalKey<FormState>();
  var namectrl = TextEditingController();
  final bioctrl = TextEditingController();
  final phonectrl = TextEditingController();
  DocumentSnapshot? userdata;
  String profileurl = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, provider, child) {
      userdata = provider.userdata;
      namectrl.text = userdata?['name'];
      bioctrl.text = userdata?['bio'];
      phonectrl.text = userdata?['phone'];
      profileurl = userdata?['profileUrl'];

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: GoogleFonts.salsa(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          provider.selectimage(context);
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Card(
                              elevation: 15,
                              shape: CircleBorder(),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(profileurl == ''
                                            ? "https://media.istockphoto.com/id/1251464080/vector/people-communication-icon-in-flat-style-people-vector-illustration-on-black-round-background.jpg?s=612x612&w=0&k=20&c=-UIAyz14n25sNlNYqDz7a4_7skVUEhFF4B2pj6vgm4g="
                                            : profileurl),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle),
                              ),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Constants.primarycolor,
                              child: Icon(
                                Icons.edit,
                                size: 15,
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Personal Details',
                      style: GoogleFonts.salsa(fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: TextFormField(
                        controller: namectrl,
                        style: GoogleFonts.salsa(),
                        decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: GoogleFonts.salsa(),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30)),
                            label: Text(
                              'Name',
                              style: GoogleFonts.salsa(),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: TextFormField(
                        controller: bioctrl,
                        style: GoogleFonts.salsa(),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: 'Bio',
                            hintStyle: GoogleFonts.salsa(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            label: Text(
                              'Bio',
                              style: GoogleFonts.salsa(),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: TextField(
                        controller: phonectrl,
                        style: GoogleFonts.salsa(),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            hintStyle: GoogleFonts.salsa(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            label: Text(
                              'Phone Number',
                              style: GoogleFonts.salsa(),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        provider.savechanges(
                            name: namectrl.text,
                            bio: bioctrl.text,
                            phone: phonectrl.text);
                        provider.getUserDetails();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.salsa(color: Constants.seccolor),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Constants.primarycolor),
                          minimumSize: MaterialStatePropertyAll(Size(160, 50))),
                    )
                  ],
                ),
              )),
        ),
      );
    });
  }
}
