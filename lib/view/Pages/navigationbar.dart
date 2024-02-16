import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/view/Pages/discover.dart';
import 'package:onetheatre/view/Pages/home.dart';
import 'package:onetheatre/view/Pages/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BotNavbar extends StatefulWidget {
  const BotNavbar({super.key});

  @override
  State<BotNavbar> createState() => _BotNavbarState();
}

class _BotNavbarState extends State<BotNavbar> {
  var currentindex = 0;
  var screens = [
    Homepage(),
    Explorepage(),
    Center(
      child: Text('Fav'),
    ),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home_filled),
              title: Text(
                'Home',
                style: GoogleFonts.salsa(),
              ),
              selectedColor: Color.fromARGB(255, 8, 182, 182),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.play_circle),
              title: Text(
                'Discover',
                style: GoogleFonts.salsa(),
              ),
              selectedColor: Color.fromARGB(255, 8, 182, 182),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite_outlined),
              title: Text(
                'Favourite',
                style: GoogleFonts.salsa(),
              ),
              selectedColor: Color.fromARGB(255, 8, 182, 182),
            ),
            SalomonBottomBarItem(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://media.gettyimages.com/id/459287470/photo/london-england-jim-carrey-attends-a-photocall-for-dumb-and-dumber-to-on-november-20-2014-in.jpg?s=612x612&w=0&k=20&c=HsvA6c9MRcPONox9ny7ZEN_IQ-3-_lGo5BVNwzc6Wvg="),
              ),
              title: Text(
                'Profile',
                style: GoogleFonts.salsa(),
              ),
              selectedColor: Color.fromARGB(255, 8, 182, 182),
            ),
          ]),
      body: screens[currentindex],
    );
  }
}
