import 'package:flutter/material.dart';
import 'package:practice_1/animation/details_page.dart';

class HeroAnimationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero Animation"),
      ),
      body: Container(
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailsPage()));
            },
            child: Hero(
                tag: "Cat",
                child: Image.asset(
                  "assets/images/cat1.jpg",
                  height: 100,
                  width: 200,
                )),
          ),
        ),
      ),
    );
  }
}
