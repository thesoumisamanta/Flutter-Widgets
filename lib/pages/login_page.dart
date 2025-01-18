import 'package:flutter/material.dart';
import 'package:practice_1/pages/dashboard_page.dart';

class LoginPage extends StatelessWidget {
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(label: Text("Username")),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(label: Text("Password")),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage(nameController.text.toString())));
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
