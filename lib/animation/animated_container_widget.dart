import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  @override
  State<AnimatedContainerWidget> createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  var _height = 200.0;
  var _width = 100.0;
  bool flag = true;
  // Color bgColor = Colors.blue;
  Decoration decor = BoxDecoration(
      borderRadius: BorderRadius.circular(10), color: Colors.blue);
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
              AnimatedContainer(
                  width: _width,
                  height: _height,
                  // color: bgColor,
                  duration: Duration(seconds: 2),
                  decoration: decor),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (flag) {
                        _width = 200.0;
                        _height = 100.0;
                        flag = false;
                        decor = BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20));
                      } else {
                        _width = 100.0;
                        _height = 200.0;
                        flag = true;
                        decor = BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10));
                      }
                    });
                  },
                  child: Text("Animate"))
            ],
          ),
        ));
  }
}
