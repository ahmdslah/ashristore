import 'package:ashristore/login_widget.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool isobsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: LoginWidget(
        butTitle: "التالي",
        hintText: "الرقم السري",
        imagePath: "assets/images/introPasswoed.png",
        title: "أدخل كلمة المرور",
        subTitle:
            "يبدو أن لديك حسابًا بهذا الرقم. يُرجى إدخال كلمة المرور للمتابعة.",
        onPressed: () {
          Navigator.pushNamed(context, "active");
        },

        prefixIcon: Icon(Icons.lock),
        obsecure: isobsecure,
        suffixIcon:
            isobsecure
                ? IconButton(
                  onPressed: () {
                    isobsecure = false;
                    setState(() {});
                  },
                  icon: Icon(Icons.remove_red_eye_outlined),
                )
                : IconButton(
                  onPressed: () {
                    isobsecure = true;
                    setState(() {});
                  },
                  icon: Icon(Icons.password),
                ),
        // suffixIcon: Icon(Icons.energy_savings_leaf),
      ),
    );
  }
}
