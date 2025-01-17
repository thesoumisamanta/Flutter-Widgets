import 'package:flutter/material.dart';

class BmiApp extends StatefulWidget {
  @override
  State<BmiApp> createState() => _BmiAppState();
}

class _BmiAppState extends State<BmiApp> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI App"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BMI",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                    label: Text("Enter your weight in kgs"),
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                    label: Text("Enter your height in feet"),
                    prefixIcon: Icon(Icons.height_rounded),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                    label: Text("Enter your height in inches"),
                    prefixIcon: Icon(Icons.height_outlined),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    var wt = wtController.text.toString();
                    var ft = ftController.text.toString();
                    var inch = inController.text.toString();

                    if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
                      try {
                        // Parsing inputs as doubles for accuracy
                        var iWt = double.parse(wt);
                        var iFt = double.parse(ft);
                        var iInch = double.parse(inch);

                        // Calculating BMI
                        var totalInch = (iFt * 12) + iInch;
                        var totalCm = totalInch * 2.54;
                        var totalMeter = totalCm / 100;
                        var bmi = iWt / (totalMeter * totalMeter);

                        setState(() {
                          result = "Your BMI is: ${bmi.toStringAsFixed(2)}";
                        });
                      } catch (e) {
                        setState(() {
                          result = "Invalid input. Please enter valid numbers.";
                        });
                      }
                    } else {
                      setState(() {
                        result = "Please fill all the required blanks.";
                      });
                    }
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  result,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
