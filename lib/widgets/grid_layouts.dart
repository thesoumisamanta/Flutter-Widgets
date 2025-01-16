import 'package:flutter/material.dart';

class GridLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arrColors = [
      Colors.amber,
      Colors.blue,
      Colors.deepOrange,
      Colors.black,
      Colors.pink,
      Colors.purple,
      Colors.green,
      Colors.red,
      Colors.cyan
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text("Grid View Layout"),
        ),
        body: GridView.builder(
          itemBuilder: (context, index) {
            return Container(
              color: arrColors[index],
            );
          },
          itemCount: arrColors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
        )
        // Column(
        //   children: [
        //     Text("Gridview count"),
        //     Container(
        //       height: 200,
        //       child: GridView.count(
        //         crossAxisCount: 5,
        //         crossAxisSpacing: 10,
        //         mainAxisSpacing: 10,
        //         children: [
        //           Container(color: arrColors[0]),
        //           Container(color: arrColors[1]),
        //           Container(color: arrColors[2]),
        //           Container(color: arrColors[3]),
        //           Container(color: arrColors[4]),
        //           Container(color: arrColors[5]),
        //           Container(color: arrColors[6]),
        //           Container(color: arrColors[7]),
        //         ],
        //       ),
        //     ),
        //     Text("Gridview extent"),
        //     Container(
        //       height: 200,
        //       child: GridView.extent(
        //         maxCrossAxisExtent: 50,
        //         crossAxisSpacing: 10,
        //         mainAxisSpacing: 10,
        //         children: [
        //           Container(color: arrColors[0]),
        //           Container(color: arrColors[1]),
        //           Container(color: arrColors[2]),
        //           Container(color: arrColors[3]),
        //           Container(color: arrColors[4]),
        //           Container(color: arrColors[5]),
        //           Container(color: arrColors[6]),
        //           Container(color: arrColors[7]),
        //         ],
        //       ),
        //     )
        //   ],
        // )
        // Container(
        //   width: 300,
        //   child: GridView.count(
        //     crossAxisCount: 4,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[0]),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[1]),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[2]),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[3]),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[4]),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[5]),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[6]),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(color: arrColors[7]),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
