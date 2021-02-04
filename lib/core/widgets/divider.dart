import 'package:flutter/material.dart';

class DooverDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(height: 1)),
      ),
    );
  }
}
