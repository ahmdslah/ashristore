import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class CreatePassword extends StatefulWidget {
  CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool isobsecure = true;
  String number = "01097801940";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage("assets/images/introCreatePass.png"),
                height: 300,
              ),
            ),
            // SizedBox(height: 20),
            TextTitle(
              text: "من أجل الأمان والسلامة، يرجى اختيار كلمة مرور",
              size: 25,
              fontweight: FontWeight.bold,
            ),

            SizedBox(height: 20),
            TextFormField(
              obscureText: isobsecure,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "ادخل اسمك",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: isobsecure,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),

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
                // suffixIc
                hintText: "ادخل كلمة المرور",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: isobsecure,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),

                // suffixIc
                hintText: "قم بتاكيد كلمة المرور",
              ),
            ),
            SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xff5EC401),
                      ),
                    ),

                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "home",
                        (route) => false,
                      );
                    },
                    child: TextTitle(
                      fontcolor: Colors.white,
                      text: "ابدء التسوق",
                      fontweight: FontWeight.bold,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
