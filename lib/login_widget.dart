import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.butTitle,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.obsecure,
    this.controller,
  });
  final String imagePath;
  final String title;
  final String butTitle;
  final String subTitle;
  final String hintText;
  final bool? obsecure;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: AssetImage(imagePath), height: 300),
          SizedBox(height: 20),
          TextTitle(text: title, size: 25, fontweight: FontWeight.bold),
          SizedBox(height: 20),
          TextTitle(text: subTitle, size: 16, fontweight: FontWeight.normal),
          SizedBox(height: 20),
          TextFormField(
            controller: controller,
            obscureText: obsecure ?? true,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText,
            ),
          ),
          SizedBox(height: 40),

          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xff5EC401)),
                  ),

                  onPressed: onPressed,
                  child: TextTitle(
                    fontcolor: Colors.white,
                    text: butTitle,
                    fontweight: FontWeight.bold,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
