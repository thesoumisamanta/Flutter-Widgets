import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green,
        title: Text("Whatsapp"),
      ),
      body: Container(
        // width: 100,
        // height: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            radius: 50,
            child: Container(
              height: 80,
              width: 80,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/cat1.jpg')),
                  Text("Tss", style: TextStyle(fontFamily: 'jersey', fontSize: 25, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            // minRadius: 50,
          ),
        ),
      ),
    );
  }
}
