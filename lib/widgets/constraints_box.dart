import 'package:flutter/material.dart';

class ConstraintsBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Constraint Box"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 220,
          minWidth: 100,
          maxHeight: 150,
          minHeight: 100
        ),
        child: ElevatedButton(onPressed: (){}, child: Text("Click"))
        ),
    );
  }
}
