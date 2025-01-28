import 'package:flutter/material.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({super.key});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true, // Automatically adjusts for the keyboard
    body: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView( // Wrap the content in a scrollable view
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Non Adani User Registration",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "First Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Enter your first name",
                      icon: Icons.person_outline),
                  const SizedBox(height: 10),
                  const Text(
                    "Middle Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Enter your middle name",
                      icon: Icons.person_outline),
                  const SizedBox(height: 10),
                  const Text(
                    "Last Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Enter your last name",
                      icon: Icons.person_outline),
                  const SizedBox(height: 10),
                  const Text(
                    "Email ID",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Enter your email",
                      email: true, icon: Icons.email_outlined),
                  const SizedBox(height: 10),
                  const Text(
                    "Contact Number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Enter your contact number",
                      phone: true, icon: Icons.phone_outlined),
                  const SizedBox(height: 10),
                  const Text(
                    "Department",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Enter your department",
                      icon: Icons.work_outline),
                  const SizedBox(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Enter password",
                      obscureText: true, icon: Icons.lock_outline),
                  const SizedBox(height: 10),
                  const Text(
                    "Re-enter Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  _buildTextField("Re-enter password",
                      obscureText: true, icon: Icons.lock_outline),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Registered Already? ",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}


  Widget _buildTextField(String hint,
      {bool email = false,
      bool phone = false,
      bool obscureText = false,
      IconData? icon}) {
    return TextFormField(
      keyboardType: phone
          ? TextInputType.phone
          : email
              ? TextInputType.emailAddress
              : TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint, 
        hintStyle: const TextStyle(
          color: Colors.grey
        ),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $hint";
        }
        if (email && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return "Enter a valid email address";
        }
        if (phone && !RegExp(r'^\d{10}$').hasMatch(value)) {
          return "Enter a valid 10-digit number";
        }
        return null;
      },
    );
  }
}
