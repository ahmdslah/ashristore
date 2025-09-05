import 'package:ashristore/login_widget.dart';
import 'package:flutter/material.dart';

class ActivationCode extends StatefulWidget {
  ActivationCode({super.key});

  @override
  State<ActivationCode> createState() => _ActivationCodeState();
}

class _ActivationCodeState extends State<ActivationCode> {
  bool isobsecure = true;
  String number = "01097801940";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: LoginWidget(
        butTitle: "التالي",
        hintText: "ادخل رمز التحقق",
        imagePath: "assets/images/introPasswoed.png",
        title: "أدخل رمز التحقق",
        subTitle: "لقد أرسلنا رسالة نصية قصيرة إلى : $number",
        onPressed: () {
          Navigator.pushNamed(context, "create");
        },
      ),
    );
  }
}
