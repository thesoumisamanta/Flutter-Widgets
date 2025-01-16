import 'package:flutter/material.dart';

class StackWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack widget"),
      ),
      body: Container(
        width: 300,
        height: 300,
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
            ),
            Positioned(
              top: 25,
              left: 25,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
