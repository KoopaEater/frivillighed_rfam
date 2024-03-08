import 'package:flutter/material.dart';

class ActivityBox extends StatelessWidget {

  final double height;

  const ActivityBox({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.greenAccent,
    );
  }
}
