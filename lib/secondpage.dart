import 'package:flutter/material.dart';

class DateTimePickerPage extends StatefulWidget {
  @override
  _DateTimePickerPageState createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> {
  DateTime pickedDate;
  DateTime time;
  @override
  void initState() {
    super.initState();
    time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Current Object',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontFamily: 'Courier'),
              ),
            ),
            Center(
              child: Text(
                this.time.hour.toString() +
                    ':' +
                    this.time.minute.toString() +
                    ':' +
                    this.time.second.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
            Center(
              child: Text(
                'Enter Your Variable',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontFamily: 'Courier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
