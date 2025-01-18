import 'package:flutter/material.dart';

class ClipRrectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clicp Rrect"),
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
