import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "About Me",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
