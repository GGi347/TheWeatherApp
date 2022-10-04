import 'package:flutter/material.dart';

class WeatherSummary extends StatelessWidget {
  final String title;
  final String value;
  WeatherSummary({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 16.0,
            color: Color.fromRGBO(255, 255, 255, 0.7),
            letterSpacing: 1.1),
      ),
      SizedBox(height: 6.0),
      Text(
        value,
        style: TextStyle(fontSize: 22.0, color: Colors.white),
      ),
    ]);
  }
}