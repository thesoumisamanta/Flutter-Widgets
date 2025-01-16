import 'package:flutter/material.dart';

TextStyle myTextStyle() {
  return TextStyle(fontSize: 25, fontWeight: FontWeight.w500);
}

TextStyle myTextStyle2({
  Color textColor = Colors.pink
}) {
  return TextStyle(
    fontSize: 30,
    color: textColor
  );
}
