import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
      ),
      body: Container(
        child: Hero(tag: "Cat", child: Image.asset("assets/images/cat1.jpg")),
      ),
    );
  }
}
