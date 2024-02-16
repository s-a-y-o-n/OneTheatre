import 'package:flutter/material.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/view/Splash_and_onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiscoverController())
      ],
      child: MaterialApp(
        home: Onboarding_screen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      ),
    );
  }
}
