import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class DropAreaPage extends StatefulWidget {
  @override
  State<DropAreaPage> createState() => _DropAreaPageState();
}

class _DropAreaPageState extends State<DropAreaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drop Area Page"),
      ),
      body: Container(
        child: Stack(
          children: [
            DropzoneView( 
            )
          ],
        ),
      ),
    );
  }

}
