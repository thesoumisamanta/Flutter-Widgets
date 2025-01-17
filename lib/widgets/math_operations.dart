import 'package:flutter/material.dart';

class MathOperations extends StatefulWidget {
  @override
  State<MathOperations> createState() => MathOperationsState();
}

class MathOperationsState extends State<MathOperations> {
  var num1Controller = TextEditingController();
  var num2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Math Operations"),
      ),
      body: Container(
        color: Colors.blue.shade300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: num1Controller,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: num2Controller,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){}, child: Text("+", style: TextStyle(fontSize: 35),)),
                  ElevatedButton(onPressed: (){}, child: Text("-", style: TextStyle(fontSize: 35),)),
                  ElevatedButton(onPressed: (){}, child: Text("*", style: TextStyle(fontSize: 35),)),
                  ElevatedButton(onPressed: (){}, child: Text("%", style: TextStyle(fontSize: 35),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
