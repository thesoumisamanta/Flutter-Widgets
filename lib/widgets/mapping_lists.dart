import 'package:flutter/material.dart';

class MappingLists extends StatelessWidget {
  var arrNames = ["Soumi", "Neel", "Pooja", "Sourya", "Gambu", "Shampoo"];
  var arrData = [
    {'name': 'Soumi', 'mobNo': 1234567890, 'unread': 1},
    {'name': 'Neel', 'mobNo': 1234567890, 'unread': 1},
    {'name': 'Pooja', 'mobNo': 1234567890, 'unread': 1},
    {'name': 'Sourya', 'mobNo': 1234567890, 'unread': 1},
    {'name': 'Gambu', 'mobNo': 1234567890, 'unread': 1},
    {'name': 'Shampoo', 'mobNo': 1234567890, 'unread': 1},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mapping List"),
        ),
        body: Container(
          child: ListView(
              children: arrData.map((value) {
            return ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(value['name'].toString()),
              subtitle: Text(value['mobNo'].toString()),
              trailing: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.green.shade400,
                child: Text(value['unread'].toString())
                ),
            );
          }).toList()),
        )
        // Container(
        //   child: ListView(
        //       children: arrNames.map((value) {
        //     return Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15),
        //           color: Colors.blueGrey,
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Center(
        //               child: Text(
        //             value,
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 color: Colors.amberAccent,
        //                 fontWeight: FontWeight.bold),
        //           )),
        //         ),
        //       ),
        //     );
        //   }).toList()),
        // ),
        );
  }
}
