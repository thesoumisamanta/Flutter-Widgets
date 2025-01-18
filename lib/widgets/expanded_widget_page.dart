import 'package:flutter/material.dart';

class ExpandedWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expanded Widget"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              width: 50,
              color: Colors.yellow,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              width: 50,
              color: Colors.green,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 100,
              width: 50,
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: 100,
              width: 50,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
