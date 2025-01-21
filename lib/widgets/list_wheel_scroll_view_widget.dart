import 'package:flutter/material.dart';

class ListWheelScrollViewWidget extends StatelessWidget {
  var arrIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListWheelViewScroll Widget")),
      body: ListWheelScrollView(
          itemExtent: 100,
          children: arrIndex.map((value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(child: Text("$value")),
                  width: double.infinity,
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                   color: Colors.amber,
                 ),
                ),
          )).toList()),
    );
  }
}
