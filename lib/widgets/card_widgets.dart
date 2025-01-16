import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardWidgets extends StatelessWidget {
  var emailText = TextEditingController();
  var passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Widget"),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          shadowColor: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Login"),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailText,
                      // enabled: false,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepOrange)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          // disabledBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //     borderSide: BorderSide(color: Colors.grey)),
                          // suffixText: "Username exists",
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.blue,
                              ))
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //     borderSide: BorderSide(color: Colors.deepPurple)),
                          ),
                    ),
                    Container(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordText,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepOrange)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          // prefixText: "password mismatched",
                          // prefixIcon: Icon(Icons.password)
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //     borderSide: BorderSide(color: Colors.deepPurple)),
                          ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String userEmail = emailText.text.toString();
                          String userPassword = passwordText.text.toString();

                          print("Email: $userEmail, Password: $userPassword");
                        },
                        child: Text("Login"))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
