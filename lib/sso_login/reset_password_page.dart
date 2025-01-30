import 'package:flutter/material.dart';
import 'package:practice_1/sso_login/enter_new_password_page.dart';
import 'package:practice_1/sso_login/user_registration_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  bool _isOtpSent = false;

  void _clearOtpFields() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
  }

  void _moveToNextField(int index) {
    if (index < _otpControllers.length - 1) {
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  bool _validateOtp() {
    for (var controller in _otpControllers) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome to",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const Text("aviio",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      )),
                  const SizedBox(height: 30),
                  const Text("Reset Password",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  if (_isOtpSent) ...[
                    const SizedBox(height: 15),
                    const Text(
                      "Please enter the 6-digit code sent to your email",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 40,
                          child: TextFormField(
                            controller: _otpControllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: "",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                _moveToNextField(index);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Didn't receive a code?"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _clearOtpFields();
                            });
                          },
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                                color: Colors.purple,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ],
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_isOtpSent) {
                          bool isOtpValid = _validateOtp();
                          if (isOtpValid) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EnterNewPasswordPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Invalid OTP! Please try again.')));
                          }
                        } else {
                          setState(() {
                            _isOtpSent = true;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _isOtpSent ? "Submit" : "Send OTP",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not registered yet? ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UserRegistrationPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                            minimumSize: Size.zero, padding: EdgeInsets.zero),
                        child: const Text(
                          "Register here",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
