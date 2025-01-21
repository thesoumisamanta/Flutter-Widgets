import 'dart:async';

import 'package:flutter/material.dart';

class CrossFadeAnimatedFramework extends StatefulWidget {
  @override
  State<CrossFadeAnimatedFramework> createState() =>
      _CrossFadeAnimatedFrameworkState();
}

class _CrossFadeAnimatedFrameworkState
    extends State<CrossFadeAnimatedFramework> {
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Timer(Duration(seconds: 5), () => reload());
  }

  void reload() {
    setState(() {
      if (flag) {
        flag = false;
      } else {
        flag = true;
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cross Fade Animated Framework"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedCrossFade(
                firstChild: Container(
                  width: 200,
                  height: 200,
                  color: Colors.green,
                ),
                secondChild: Image.asset(
                  "assets/images/cat1.jpg",
                  width: 200,
                  height: 200,
                ),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState:
                    flag ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: Duration(seconds: 2)),
            ElevatedButton(
                onPressed: () {
                  // setState(() {
                  //   flag = false;
                  // });
                  reload();
                },
                child: Text(flag ? "Cat" : "Color"))
          ],
        ),
      ),
    );
  }
}
