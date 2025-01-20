import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  @override
  State<AnimatedContainerWidget> createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  var _height = 100.0;
  var _width = 200.0;
  bool flag = true;
  // Color bgColor = Colors.blue;
  Decoration decor =
      BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.blue);
  String structName = "Rectangle";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animated Container widget"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                      width: _width,
                      height: _height,
                      // color: bgColor,
                      duration: Duration(seconds: 2),
                      curve: Curves.easeInOut,
                      decoration: decor),
                  Text(
                    structName,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (flag) {
                        _width = 200.0;
                        _height = 200.0;
                        flag = false;
                        structName = "Circle";
                        decor = BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(100));
                      } else {
                        _width = 200.0;
                        _height = 100.0;
                        flag = true;
                        structName = "Rectangle";
                        decor = BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20));
                      }
                    });
                  },
                  child: Text("Animate"))
            ],
          ),
        ));
  }
}
