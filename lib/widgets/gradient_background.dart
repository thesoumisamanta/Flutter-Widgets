import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gradient Background"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [
                  // Colors.green,
                  Color.fromARGB(255, 247, 207, 147),
                  Color.fromARGB(255, 249, 188, 97),
                  Color.fromARGB(255, 248, 163, 35),
                ],
                // LinearGradient(
                //   colors: [
                //     // Colors.green,
                //      Color.fromARGB(255, 247, 207, 147),
                //      Color.fromARGB(255, 249, 188, 97),
                //      Color.fromARGB(255, 248, 163, 35),
                // ],

                // begin: FractionalOffset(1.0, 0.0),
                // end: FractionalOffset(0.0, 1.0),
                center: Alignment.bottomCenter,
                stops: [0.2, 0.4, 0.6])),
      ),
    );
  }
}
