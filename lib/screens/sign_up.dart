import 'package:ashristore/const.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/screens/next_button.dart';
import 'package:ashristore/text_form_widget.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailpattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
  String _fName = "";
  String _lName = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  bool pressed = false;
  String? _validateFName(String? val) {
    if (_fName.isEmpty) {
      return "Please Enter Your First Name";
    }
    return null;
  }

  String? _validateLName(String? val) {
    if (_lName.isEmpty) {
      return "Please Enter Your Last Name";
    }
    return null;
  }

  String? _validateEmail(String? val) {
    if (_email.isEmpty) {
      return "Please Enter Your Email";
    }
    if (!emailpattern.hasMatch(_email)) {
      return "Please Enter Valid Email";
    }
    return null;
  }

  String? _validatePassword(String? val) {
    if (_password.isEmpty || _confirmPassword.isEmpty) {
      return "Please Enter Your Password";
    }
    if (_password != _confirmPassword) {
      return "The password Doesnt match ";
    }
    if (_password.length < 8) {
      return "The password lenth must be over 8 charahcters ";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is UserSignupSuccess) {
          Navigator.pop(context);
          context.read<UserCubit>().clearSignup();
          showsuccessdialog(context);
        } else if (state is UserSignupFailed) {
          showfaileddialog(context, state);
        }
      },
      builder: (context, state) {
        double screenHeight = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<UserCubit>().clearSignup();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/images/logo.png")),
                  TextTitle(
                    text: "مرحبا بك في العشري ماركت",
                    size: 24,
                    fontweight: FontWeight.bold,
                  ),
                  SizedBox(height: screenHeight * .1),
                  Form(
                    key: _formKey,

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormWidget(
                                hintText: "الاسم الاول",
                                controller: context.read<UserCubit>().fName,
                                obsecure: false,
                                errStyle: TextStyle(color: Colors.red),
                                onChanged: (val) {
                                  _fName = val;
                                  context.read<UserCubit>().setState();
                                },
                                validator: _validateFName,
                              ),
                            ),
                            SizedBox(width: screenHeight * .05),
                            Expanded(
                              child: TextFormWidget(
                                hintText: "الاسم الاخير",

                                controller: context.read<UserCubit>().lName,
                                obsecure: false,
                                onChanged: (val) {
                                  _lName = val;
                                  context.read<UserCubit>().setState();
                                },
                                validator: _validateLName,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .05),

                        TextFormWidget(
                          hintText: "ادخل الايميل او رقم الهاتف",
                          controller: context.read<UserCubit>().email,
                          obsecure: false,
                          onChanged: (val) {
                            _email = val;
                            context.read<UserCubit>().setState();
                          },
                          validator: _validateEmail,
                        ),
                        SizedBox(height: screenHeight * .05),
                        TextFormWidget(
                          hintText: "ادخل الرقم السري",
                          controller: context.read<UserCubit>().password,
                          onChanged: (val) {
                            _password = val;
                            context.read<UserCubit>().setState();
                          },
                          validator: _validatePassword,
                        ),
                        SizedBox(height: screenHeight * .05),
                        TextFormWidget(
                          hintText: "قم بتاكيد الرقم السري",
                          controller: context.read<UserCubit>().confirmPassword,
                          onChanged: (val) {
                            _confirmPassword = val;
                            context.read<UserCubit>().setState();
                          },
                          validator: _validatePassword,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * .05),
                  state is UserSignupLoading
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
                        text: "انشاء حساب",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UserCubit>().signUp();
                          }
                        },
                      ),
                  SizedBox(height: screenHeight * .1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showfaileddialog(BuildContext context, UserSignupFailed state) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black54, // background overlay
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink(); // required, but we use transitionBuilder
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 60),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showsuccessdialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black54, // background overlay
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 70),
                  const SizedBox(height: 12),
                  const Text(
                    "Success!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextTitle(
                    textAlign: TextAlign.end,

                    fontweight: FontWeight.bold,
                    text: "The Email is created successfully.",
                    size: 20,
                    fontcolor: kPColor,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const TextTitle(
                      text: "OK",
                      size: 12,
                      fontcolor: Colors.white,
                      fontweight: FontWeight.bold,
                    ),
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
