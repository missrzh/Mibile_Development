import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app1/charts.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffff6101),
      ),
      home: HomePage(),
    );
  }
}
