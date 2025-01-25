import 'package:flutter/material.dart';

class CustomTextField
 extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onImagePick;

  const CustomTextField
  ({
    Key? key,
    required this.controller,
    required this.onImagePick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0),
                    borderSide: BorderSide(color: Colors.grey), 
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: onImagePick,
                  ),
                  // contentPadding: EdgeInsets.symmetric(vertical: 0.0), 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
