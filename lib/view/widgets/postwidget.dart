import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Postwidget extends StatelessWidget {
  final NetworkImage image;
  final NetworkImage profileimage;
  final int Userid;
  final String caption;
  Postwidget(
      {required this.Userid,
      required this.profileimage,
      required this.image,
      required this.caption});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 35, 35, 35),
      elevation: 10,
      shadowColor: Color.fromARGB(255, 30, 30, 30),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: profileimage,
                maxRadius: 13,
              ),
              title: Text(
                "${Userid}",
                style: GoogleFonts.salsa(fontSize: 15, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                caption,
                style: GoogleFonts.salsa(fontSize: 17, color: Colors.white),
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(image: image, fit: BoxFit.fill)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    label: Text(
                      '232',
                      style: GoogleFonts.salsa(color: Colors.white),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mode_comment,
                      color: Colors.white,
                    ),
                    label: Text('122',
                        style: GoogleFonts.salsa(color: Colors.white))),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    label: Text('2',
                        style: GoogleFonts.salsa(color: Colors.white))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
