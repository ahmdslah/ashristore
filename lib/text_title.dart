import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.text,
    required this.size,
    required this.fontweight,
    this.fontcolor,
  });
  final String text;
  final double size;
  final FontWeight fontweight;
  final Color? fontcolor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: fontcolor,
        fontSize: size,
        fontWeight: fontweight,
      ),
    );
  }
}
