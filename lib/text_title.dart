import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.text,
    this.size,
    this.fontweight,
    this.fontcolor,
    this.textAlign,
  });
  final String text;
  final double? size;
  final FontWeight? fontweight;
  final Color? fontcolor;
  final TextAlign? textAlign;
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
