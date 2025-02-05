import 'package:flutter/material.dart';

class TweenAnimationPartTwo extends StatefulWidget {
  @override
  State<TweenAnimationPartTwo> createState() => _TweenAnimationPartTwoState();
}

class _TweenAnimationPartTwoState extends State<TweenAnimationPartTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  var listRadius = [100.0, 150.0, 200.0, 250.0, 300.0];

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tween Animation Ripple Effects'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildContainer(listRadius[0]),
            buildContainer(listRadius[1]),
            buildContainer(listRadius[2]),
            buildContainer(listRadius[3]),
            buildContainer(listRadius[4]),
            const Icon(Icons.add_call, color: Colors.white,)
          ],
        ),
      ),
    );
  }

  Widget buildContainer(double radius) {
    return Container(
      width: radius * _animationController.value,
      height: radius * _animationController.value,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(1.0 - _animationController.value),
      ),
    );
  }
}