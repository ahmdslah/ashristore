import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    this.hintText,
    this.obsecure,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.onPressed,
    this.errStyle,
    this.onChanged,
    this.validator,
  });
  final String? hintText;
  final bool? obsecure;
  final Icon? prefixIcon;
  final TextStyle? errStyle;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final Function()? onPressed;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecure ?? true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xff005555), width: 2),
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        errorStyle: errStyle,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
