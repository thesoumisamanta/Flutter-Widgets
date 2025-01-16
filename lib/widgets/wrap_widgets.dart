import 'package:flutter/material.dart';

class WrapWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wrap widget"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Wrap(
                direction: Axis.vertical,
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.yellow,
                    ),
                    Container(
                      width: 60,
                      height: 100,
                      color: Colors.red,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                    ),
                    Container(
                      width: 70,
                      height: 100,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 50,
                      height: 100,
                      color: Colors.orange,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.pink,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.brown,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.cyan,
                    ),
                  ],
              ),
      ),
      
      // Column(
      //   children: [
          // Container(
          //   child: SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              // child: Row(
              //   children: [
              //     Container(
              //       width: 100,
              //       height: 100,
              //       color: Colors.yellow,
              //     ),
              //     Container(
              //       width: 100,
              //       height: 100,
              //       color: Colors.red,
              //     ),
              //     Container(
              //       width: 100,
              //       height: 100,
              //       color: Colors.green,
              //     ),
              //     Container(
              //       width: 100,
              //       height: 100,
              //       color: Colors.blue,
              //     ),
                  
              //   ],
              // ),
          //   ),
          // ),
          // SizedBox(height: 10,),
      //     Container(
      //       child: 
      //     )
      //   ],
      // ),
    );
  }
}
