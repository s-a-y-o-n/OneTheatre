import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:onetheatre/view/Login_and_registration/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding_screen extends StatefulWidget {
  const Onboarding_screen({super.key});

  @override
  State<Onboarding_screen> createState() => _Onboarding_screenState();
}

class _Onboarding_screenState extends State<Onboarding_screen> {
  PageController _controller = PageController();
  bool lastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              lastpage = (index == 2);
            });
          },
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/selecting.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Color.fromARGB(5, 0, 0, 0),
                          Color.fromARGB(220, 0, 0, 0)
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Wanna Find Something Intresting?',
                            maxLines: 2,
                            style: GoogleFonts.salsa(
                                textStyle: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset("assets/animations/shareanimi.json"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Built a Community',
                    style: GoogleFonts.salsa(
                        textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Text(
                    'Find Friends And Share Your Reviews With Them',
                    style: GoogleFonts.salsa(
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.white)),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/getstarted.jpg"),
                      fit: BoxFit.cover)),
              child: Container(
                alignment: Alignment(0.75, 0.35),
                child: Padding(
                  padding: const EdgeInsets.only(left: 190, right: 20),
                  child: Text(
                    "Let's Get This Done!",
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    style: GoogleFonts.salsa(
                        textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment(0, 0.85),
          child: lastpage
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: WormEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            activeDotColor: Color.fromARGB(255, 8, 182, 182)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStatePropertyAll(Size(400, 45)),
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 8, 182, 182))),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.salsa(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ))
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          _controller.jumpToPage(2);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(color: Colors.white),
                        )),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: Color.fromARGB(255, 8, 182, 182)),
                    ),
                    TextButton(
                        onPressed: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Next',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
        )
      ],
    ));
  }
}
