import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logins extends StatelessWidget {
  const Logins({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.white),

          body: LoginWidget(
            obsecure: false,
            butTitle: "التالي",
            hintText: "5678 1234 010",
            imagePath: "assets/images/introPhone.png",
            title: "أدخل رقم هاتفك المحمول",
            subTitle:
                "نحتاج إلى التحقق من هويتك. سنرسل لك رمز تحقق لمرة واحدة.",
            controller: context.read<UserCubit>().phoneNumber,
            onPressed: () {
              context.read<UserCubit>().signin();

              Navigator.pushNamed(context, "password");
            },
            prefixIcon: Icon(Icons.phone),
            // suffixIcon: Icon(Icons.energy_savings_leaf),
          ),
        );
      },
    );
  }
}
