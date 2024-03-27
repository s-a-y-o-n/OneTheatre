import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Postwidget extends StatefulWidget {
  final NetworkImage image;
  final NetworkImage profileimage;
  final String Userid;
  final String caption;
  Postwidget(
      {required this.Userid,
      required this.profileimage,
      required this.image,
      required this.caption});

  @override
  State<Postwidget> createState() => _PostwidgetState();
}

class _PostwidgetState extends State<Postwidget> {
  String? name;

  Future<String> fetchUser() async {
    final docRef =
        FirebaseFirestore.instance.collection('Users').doc(widget.Userid);
    final docSnapshot = await docRef.get();
    final userData = docSnapshot.data()!;
    return userData['name'];
  }

  @override
  void setState(VoidCallback fn) async {
    name = await fetchUser();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // fetchUser();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: widget.profileimage,
              maxRadius: 13,
            ),
            title: Text(
              "${name}",
              style: GoogleFonts.salsa(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.caption,
              style: GoogleFonts.salsa(fontSize: 17),
            ),
          ),
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: widget.image, fit: BoxFit.contain)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: Text(
                    '232',
                    style: GoogleFonts.salsa(),
                  )),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mode_comment,
                  ),
                  label: Text('122', style: GoogleFonts.salsa())),
            ],
          )
        ],
      ),
    );
  }
}
