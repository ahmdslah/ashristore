import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class Rectdata extends StatelessWidget {
  const Rectdata({
    super.key,
    required this.title,
    this.ontap,
    this.prefixIcon,
    required this.withArrow,
  });
  final String title;
  final Widget? prefixIcon;
  final Function()? ontap;
  final bool withArrow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: InkWell(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: .5)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                prefixIcon != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: prefixIcon!,
                    )
                    : Container(),
                TextTitle(text: title, size: 15),
                Spacer(),
                withArrow ? Icon(Icons.arrow_forward_ios) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
