import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice_1/pages/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[200],
        child: Center(
            child: Text(
          "thesoumisamanta",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

