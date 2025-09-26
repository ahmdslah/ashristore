import 'package:ashristore/const.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/excel/excel.dart';
import 'package:ashristore/screens/next_button.dart';
import 'package:ashristore/text_form_widget.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class Login extends StatelessWidget {
  Login({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) async {
        if (state is UserLoginFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserLoginSuccess) {
          Navigator.pushReplacementNamed(context, "home");
        } else if (state is AdminLoginSuccess) {
          Navigator.pushReplacementNamed(context, "adminHome");
        }
      },
      builder: (context, state) {
        double screenHeight = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(toolbarHeight: 10, backgroundColor: Colors.white),

          body: SingleChildScrollView(
            child: Padding(
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
                  TextFormWidget(
                    obsecure: false,
                    hintText: "ادخل الايميل او رقم الهاتف",
                    controller: context.read<UserCubit>().emailL,
                  ),
                  SizedBox(height: screenHeight * .05),
                  TextFormWidget(
                    obsecure: false,

                    hintText: "ادخل الرقم السري",
                    controller: context.read<UserCubit>().passwordL,
                  ),
                  SizedBox(height: screenHeight * .05),
                  state is UserLoginLoading
                      ? Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  kSColor,
                                ),
                              ),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      )
                      : NextButton(
                        text: "تسجيل الدخول",
                        onPressed: () {
                          context.read<UserCubit>().login();
                        },
                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextTitle(
                        text: "ليس لديك حساب؟",
                        fontcolor: kPColor,
                        size: 20,
                        fontweight: FontWeight.bold,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "signup");
                        },
                        child: TextTitle(
                          text: "انشاء حساب",
                          size: 20,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
