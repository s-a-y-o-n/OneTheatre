import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Pages/navigationbar.dart';
import 'package:onetheatre/view/Splash_and_onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CheckLogin())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Constants.primarycolor),
          child: ImageIcon(
            AssetImage("assets/images/logo.png"),
            size: 140,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Provider.of<ProfileController>(context).getUserDetails();
              return const BotNavbar();
            } else {
              return const Onboarding_screen();
            }
          }),
    );
  }
}
