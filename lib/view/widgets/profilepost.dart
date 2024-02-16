import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePostwidget extends StatelessWidget {
  final NetworkImage image;

  final String caption;
  ProfilePostwidget({required this.image, required this.caption});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 240,
                height: 130,
                child: Text(
                  caption,
                  maxLines: null,
                  style: GoogleFonts.salsa(fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: image, fit: BoxFit.fill)),
              ),
            ),
          ]),
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
                  label: Text('122',
                      style: GoogleFonts.salsa(color: Colors.white))),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                  ),
                  label: Text('2', style: GoogleFonts.salsa())),
            ],
          )
        ],
      ),
    );
  }
}
