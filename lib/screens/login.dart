import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/screens/next_button.dart';
import 'package:ashristore/text_form_widget.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double screenHeight = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(toolbarHeight: 10, backgroundColor: Colors.white),

          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(height: screenHeight * .2),
                Image(image: AssetImage("assets/images/logo.png")),
                TextTitle(
                  text: "مرحبا بك في العشري ماركت",
                  size: 24,
                  fontweight: FontWeight.bold,
                ),
                SizedBox(height: screenHeight * .1),
                TextFormWidget(hintText: "ادخل الايميل او رقم الهاتف"),
                SizedBox(height: screenHeight * .05),
                TextFormWidget(hintText: "ادخل الرقم السري"),
                SizedBox(height: screenHeight * .05),
                NextButton(text: "تسجيل الدخول"),
                SizedBox(height: screenHeight * .1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterSocialButton(
                      onTap: () {},
                      buttonType: ButtonType.facebook,
                      iconSize: 30,
                      mini: true,
                    ),
                    SizedBox(width: 20),
                    FlutterSocialButton(
                      onTap: () {},
                      iconSize: 30,
                      buttonType: ButtonType.google,
                      mini: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
