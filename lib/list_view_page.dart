import 'package:flutter/material.dart';

var arrNames = ["Soumi", "Pooja", "Neel", "Sourya", "Tss", "Gambu", "shampoo", "cs", "software", "engineer"];

class ListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("List view page")),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Text(
              arrNames[index],
              style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
            );
          },
          itemCount: arrNames.length,
          // reverse: true,
          // itemExtent: 150,
          // scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => Divider(
            height: 20,
            thickness: 2,
          ),
        )
        
        
        // ListView.builder(
        //   itemBuilder: (context, index) {
        //     return Text(
        //       arrNames[index],
        //       style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
        //     );
        //   },
        //   itemCount: arrNames.length,
        //   // reverse: true,
        //   // itemExtent: 150,
        //   scrollDirection: Axis.horizontal,
        // )

        // ListView(
        //   scrollDirection: Axis.horizontal,
        //   reverse: true,
        //   children: [
        //     Text("one", style: TextStyle(fontSize: 25),),
        //     Text("two", style: TextStyle(fontSize: 25),),
        //     Container(
        //       width: 200,
        //       height: 200,
        //       decoration: BoxDecoration(border: Border.all(
        //         color: Colors.green,
        //         width: 3
        //       )),
        //     ),
        //     Container(
        //       width: 200,
        //       height: 200,
        //       decoration: BoxDecoration(border: Border.all(
        //         color: Colors.pink,
        //         width: 3
        //       )),
        //     ),
        //     Container(
        //       width: 200,
        //       height: 200,
        //       decoration: BoxDecoration(border: Border.all(
        //         color: Colors.yellow,
        //         width: 3
        //       )),
        //     ),
        //     Container(
        //       width: 200,
        //       height: 200,
        //       decoration: BoxDecoration(border: Border.all(
        //         color: Colors.blue,
        //         width: 3
        //       )),
        //     ),
        //     Container(
        //       width: 200,
        //       height: 200,
        //       decoration: BoxDecoration(border: Border.all(
        //         color: Colors.red,
        //         width: 3
        //       )),
        //     ),
        //     ]
        // ),
        );
  }
}
