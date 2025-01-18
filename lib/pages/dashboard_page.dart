import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  var nameFromLogin;

  DashboardPage(
    this.nameFromLogin
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Page"),
      ),
      body: Center(
        child: Container(
          child: Text("$nameFromLogin, Welcome to Dashboard"),
        ),
      ),
    );
  }
}
