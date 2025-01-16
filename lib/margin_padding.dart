import 'package:flutter/material.dart';
import 'package:practice_1/list_view_page.dart';

class MarginPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Margin & padding"),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('$index'),
                title: Text(arrNames[index]),
                subtitle: Text('Number'),
                trailing: Icon(Icons.add),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: 10, thickness: 2);
            },
            itemCount: arrNames.length)

        // Column(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(top: 10, left: 20),
        //       child: Text(
        //         "Hello World",
        //         style: TextStyle(
        //             fontSize: 25,
        //             color: Colors.green,
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //     Container(
        //       color: Colors.pink,
        //       height: 100,
        //       width: 100,
        //       margin: EdgeInsets.all(8.0),
        //       child: Padding(padding: EdgeInsets.all(16.0),
        //       child: Text("Soumi", style: TextStyle(color: Colors.white),)),
        //     )
        //   ],
        // ),
        );
  }
}
