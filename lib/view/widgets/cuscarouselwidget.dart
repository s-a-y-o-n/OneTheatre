import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Carousel_slide extends StatelessWidget {
  VoidCallback onTap;
  final NetworkImage image;
  final String title;
  final String rating;

  Carousel_slide(
      {required this.onTap,
      required this.image,
      required this.title,
      required this.rating});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.cover)),
          child: Container(
            height: 350,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(5, 0, 0, 0),
              Color.fromARGB(220, 0, 0, 0)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.salsa(
                      textStyle: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(children: [
                  Text(
                    "${rating}",
                    style: GoogleFonts.salsa(
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellowAccent,
                    size: 20,
                  )
                ]),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
