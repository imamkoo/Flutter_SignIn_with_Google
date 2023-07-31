import 'package:GoogleLogin/pages/map_page.dart';
import 'package:GoogleLogin/pages/sign_in_page.dart';
import 'package:GoogleLogin/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/map': (context) => GoogleMapsPage(),
      },
    );
  }
}
