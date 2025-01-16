import 'package:flutter/material.dart';
import 'package:practice_1/circular_avatar.dart';
import 'package:practice_1/customs/rounded_button.dart';
import 'package:practice_1/expanded_widget_page.dart';
import 'package:practice_1/functions/callback_functions.dart';
import 'package:practice_1/list_view_page.dart';
import 'package:practice_1/margin_padding.dart';
import 'package:practice_1/ui_helper/util.dart';
import 'package:practice_1/widgets/card_widgets.dart';
import 'package:practice_1/widgets/current_date_time.dart';
import 'package:practice_1/widgets/grid_layouts.dart';
import 'package:practice_1/widgets/stack_widgets.dart';
import 'package:practice_1/widgets/wrap_widgets.dart';

void main(List<String> args) {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Flutter App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
          ),
          textTheme: TextTheme(
              headlineLarge:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              titleSmall:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
      home: RichTextWidget(),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rich Text Widget"),
      ),
      body: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.amber,
            fontSize: 25
          ),
          children: <TextSpan>[
            TextSpan(text: 'Hello '),
            TextSpan(text: 'Mr ', style: TextStyle(fontSize: 30, color: Colors.blue)),
            TextSpan(text: 'Gu', style: TextStyle(fontSize: 40, color: Colors.red, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
          ]
      ))
      // Row(
      //   children: [
      //     Text("Hello ", style: TextStyle(fontSize: 25, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
      //     Text("World", style: TextStyle(fontSize: 40, color: Colors.blue, fontWeight: FontWeight.bold),)
      //   ],
      // ),
    );

  }
}

class SizedBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sized box Widget"),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(onPressed: () {}, child: Text("click")),
          ),
          SizedBox.square(
            dimension: 100,
            child: ElevatedButton(onPressed: () {}, child: Text("Button")),
          )
        ],
      ),
    );
  }
}

class WidgetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Widget Page"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: RoundedButton(
                  btnName: 'Login',
                  icon: Icon(Icons.lock),
                  callback: () {
                    print("Login Clicked");
                  },
                  textStyle: myTextStyle(),
                ),
              ),
              Container(
                width: 160,
                child: RoundedButton(
                  btnName: 'Sign up',
                  bgColor: Colors.yellow,
                  icon: Icon(Icons.safety_check),
                  callback: () {
                    print("sign up Clicked");
                  },
                  textStyle: myTextStyle(),
                ),
              ),
            ],
          ),
        ));
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Screen"),
        // backgroundColor: Colors.red,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                // color: Colors.amberAccent,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  // color: Colors.amberAccent,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(21),
                        bottomRight: Radius.circular(21)),
                    border: Border.all(width: 4, color: Colors.pink),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: const Color.fromARGB(255, 155, 246, 246),
                          spreadRadius: 10)
                    ],
                    // shape: BoxShape.circle
                  ),
                ),
              ),
            ),
            Text("Hello world",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.green)),
            Text("Hello world", style: Theme.of(context).textTheme.titleSmall),
            Text(
              "Hello World",
              style: myTextStyle(),
            ),
            Text("Soumi", style: myTextStyle2()),
            Text("Soumi", style: myTextStyle2(textColor: Colors.blueGrey))
          ],
        ),
      ),
    );
  }
}
