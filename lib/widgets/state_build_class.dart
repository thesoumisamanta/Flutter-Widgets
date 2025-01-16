import 'package:flutter/material.dart';

class StateBuildClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyStateBuildClass();
  }
}

class MyStateBuildClass extends State<StateBuildClass> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("State Class"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Count: $count",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text(
                  "Increment",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
