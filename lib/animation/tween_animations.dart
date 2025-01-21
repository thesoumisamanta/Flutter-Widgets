import 'package:flutter/material.dart';

class TweenAnimations extends StatefulWidget {
  @override
  State<TweenAnimations> createState() => _TwinAnimationsState();
}

class _TwinAnimationsState extends State<TweenAnimations>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late Animation colorAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    animation = Tween(begin: 0.0, end: 300.0).animate(animationController);
    colorAnimation = Tween(begin: Colors.red, end: Colors.yellow).animate(animationController);

    animationController.addListener(() {
      // print(animation.value);
      setState(() {});
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Twin Animations"),
      ),
      body: Center(
          child: Container(
        width: animation.value,
        height: animation.value,
        color: Colors.blue,
      )),
    );
  }
}
