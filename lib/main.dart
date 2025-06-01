import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/controller/postcontroller.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/firebase_options.dart';
import 'package:onetheatre/view/Splash_and_onboarding/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiscoverController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => PostController())
      ],
      child: MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      ),
    );
  }
}
