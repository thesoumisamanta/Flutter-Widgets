import 'package:flutter/material.dart';

class ComplexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex Layout"),
      ),
      body: Stack(
        children: [
          //left bar
          Positioned(
            left: 0,
            top: 60,
            bottom: 200,
            width: 60,
            child: Container(
              color: Colors.lightGreenAccent,
            ),
          ),
          //right bar
          Positioned(
            right: 0,
            top: 0,
            bottom: 200,
            width: 60,
            child: Container(
              color: Colors.lightGreenAccent,
            ),
          ),
          //top bar
          Positioned(
            top: 0,
            left: 0,
            right: 60,
            height: 60,
            child: Container(
              color: Colors.amber,
            ),
          ),
          //center top rectangle
          Positioned(
            left: 80,
            height: 80,
            top: 80,
            right: 80,
            child: Container(color: Colors.lime,)),
          //bottom bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 60,
            child: Container(color: Colors.amberAccent,))
        ],
      ),
    );
  }
}
