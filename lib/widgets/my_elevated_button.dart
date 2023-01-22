import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onPressed;

  const MyElevatedButton(
      {super.key,
      required this.child,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 300,
      child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.grey.shade400),
              overlayColor: MaterialStateProperty.all(Colors.amber),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.amber))))),
    );
  }
}
