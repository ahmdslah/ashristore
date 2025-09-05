import 'package:ashristore/login_widget.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),

      body: LoginWidget(
        butTitle: "التالي",
        hintText: "5678 1234 010",
        imagePath: "assets/images/introPhone.png",
        title: "أدخل رقم هاتفك المحمول",
        subTitle: "نحتاج إلى التحقق من هويتك. سنرسل لك رمز تحقق لمرة واحدة.",
        onPressed: () {
          Navigator.pushNamed(context, "password");
        },
        prefixIcon: Icon(Icons.phone),
        // suffixIcon: Icon(Icons.energy_savings_leaf),
      ),
    );
  }
}
