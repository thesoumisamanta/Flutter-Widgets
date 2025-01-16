import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallbackFunctions extends StatefulWidget {
  const CallbackFunctions({Key? key}) : super(key: key);

  @override
  State<CallbackFunctions> createState() => _CallbackFunctionsState();
}

class _CallbackFunctionsState extends State<CallbackFunctions> {
  callback() {
    print("Clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Callback Functions"),
      ),
      body: ElevatedButton(onPressed: callback, child: Text("Click me")),
    );
  }
}
