import 'package:ashristore/const.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontSize = 20,
    this.fontweight = FontWeight.bold,
  });
  final Function()? onPressed;
  final double? fontSize;
  final FontWeight? fontweight;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(kSColor),
            ),
            onPressed: onPressed,
            child: TextTitle(
              text: text,
              fontcolor: kPColor,
              size: fontSize!,
              fontweight: fontweight!,
            ),
          ),
        ),
      ],
    );
  }
}
