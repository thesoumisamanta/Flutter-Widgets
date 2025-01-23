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
              child: Container(
                color: Colors.lime,
              )),
          //center square box
          Positioned(
              left: 80,
              right: 80,
              top: 180,
              height: 110,
              // width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.green,
                    width: 110,
                  ),
                  Container(
                    color: Colors.green,
                    width: 110,
                  )
                ],
              )),
          //bottom rectangle
          Positioned(
              top: 320,
              left: 80,
              right: 80,
              child: Container(
                color: Colors.orangeAccent,
                height: 130,
              )),
          // bottom square box
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.red[200],
                width: 80,
              ),
              Container(
                color: Colors.red[200],
                width: 80,
              ),
              Container(
                color: Colors.red[200],
                width: 80,
              ),
              Container(
                color: Colors.red[200],
                width: 80,
              ),
            ],
          )),
          //bottom bar
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 60,
              child: Container(
                color: Colors.amberAccent,
              ))
        ],
      ),
    );
  }
}
