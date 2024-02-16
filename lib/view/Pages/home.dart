import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/view/widgets/postwidget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            title: RichText(
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate(List.generate(20, (index) {
            return Postwidget(
                Userid: index,
                profileimage: NetworkImage(
                    "https://images.unsplash.com/photo-1706648568426-66c073d7de5c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOXx8fGVufDB8fHx8fA%3D%3D"),
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1535016120720-40c646be5580?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bW92aWV8ZW58MHx8MHx8fDA%3D"),
                caption:
                    "In the tranquil embrace of twilight, when the sun's fiery glow recedes beyond the horizon, the world undergoes a subtle transformation. Shadows lengthen, casting ephemeral shapes upon the earth, while whispers of the day's lingering secrets linger in the air. It is a time of transition, where the boundaries between reality and imagination blur, and the mundane yields to the enchantment of possibility.");
          })))
        ],
      ),
    );
  }
}
