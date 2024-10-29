import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final VoidCallback fun;
  double width, height, borderRadius;
  Color bg;
  String text;
  Button(
      {super.key,
      required this.fun,
      required this.text,
      this.width = 200,
      this.height = 50,
      this.bg = Colors.blue,
      this.borderRadius = 10.0});

  @override
  _button createState() => _button();
}

class _button extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.fun,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: widget.bg,
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: Center(
          child: Text(widget.text),
        ),
      ),
    );
  }
}
