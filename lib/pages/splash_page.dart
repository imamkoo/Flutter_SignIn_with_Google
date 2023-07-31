import 'dart:async';

import 'package:GoogleLogin/theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        '/sign-in',
        (route) => false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          width: 140,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/logo.png')),
          ),
        ),
      ),
    );
  }
}
