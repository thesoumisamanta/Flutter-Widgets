import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 200,
                height: 100,
                color: Colors.amber,
                child: Center(
                    child: Text(
                  "Container",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      backgroundColor: Colors.redAccent),
                )),
              ),
            ),
            TextButton(
                onPressed: () {},
                onLongPress: () {
                  print("Long Pressed");
                },
                style:
                    TextButton.styleFrom(backgroundColor: Colors.greenAccent),
                child: Text("Text Button")),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Elevated Button",
                  style: TextStyle(color: Colors.redAccent),
                )),
            OutlinedButton(onPressed: () {}, child: Text("Outlined Button")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.remove),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 100,
                  width: 100,
                  child: InkWell(
                      onTap: () {
                        print("Cat tapped");
                      },
                      child: Image.asset('assets/images/cat1.jpg'))),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent, width: 2)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/cat2.jpg')),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/cat1.jpg')),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/cat2.jpg')),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/cat1.jpg')),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/cat2.jpg')),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("Single tap");
              },
              onDoubleTap: () {
                print("Double tap");
              },
              onLongPress: () {
                print("Long pressed");
              },
              child: Container(
                height: 50,
                width: 50,
                color: Colors.greenAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
