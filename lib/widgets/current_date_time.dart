import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateTime extends StatefulWidget {
  @override
  _CurrentDateTimeState createState() => _CurrentDateTimeState();
}

class _CurrentDateTimeState extends State<CurrentDateTime> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text("Date & Time"),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   '${time.year}: ${time.day} ${time.hour} : ${time.second}',
              //   style: TextStyle(fontSize: 25),
              // ),
              // Text(
              //   '${DateFormat('yyyy-MM-dd HH:mm:ss').format(time)}',
              //   style: TextStyle(fontSize: 25),
              // ),
              // Text(
              //   '${DateFormat.yMMMEd().format(time)}',
              //   style: TextStyle(fontSize: 25),
              // ),
              // ElevatedButton(
              //     onPressed: () {
              //       setState(() {});
              //     },
              //     child: Text("Current time"))
              Text(
                'Select Date',
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                  onPressed: () async {
                    DateTime now = DateTime.now();
                    DateTime lastDate = DateTime(2025);

                    DateTime? datePicked = await showDatePicker(
                      context: context,
                      initialDate: now.isBefore(lastDate) ? now : lastDate,
                      firstDate: DateTime(2021),
                      lastDate: lastDate,
                    );
                    if (datePicked != null) {
                      print(
                          'Date selected: ${datePicked.day}-${datePicked.month}-${datePicked.year}');
                    }
                  },
                  child: Text('Show')),
              ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial);

                    if (pickedTime != null) {
                      print(
                          'Time Selected: ${pickedTime.hour}:${pickedTime.minute}');
                    }
                  },
                  child: Text("Select time"))
            ],
          ),
        ),
      ),
    );
  }
}
