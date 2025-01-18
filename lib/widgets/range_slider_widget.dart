import 'package:flutter/material.dart';

class RangeSliderWidget extends StatefulWidget {
  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  RangeValues values = RangeValues(0, 10);

  @override
  Widget build(BuildContext context) {
    RangeLabels labels =
        RangeLabels(values.start.toString(), values.end.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Range Slider"),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Center(
              child: RangeSlider(
                  values: values,
                  labels: labels,
                  divisions: 10,
                  min: 0,
                  max: 10,
                  onChanged: (newValue) {
                    values = newValue;
                    print("${newValue.start}, ${newValue.end}");
                    setState(() {});
                  })),
        ),
      ),
    );
  }
}
