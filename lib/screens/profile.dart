import 'package:ashristore/components/rectData.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/text_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
            ),
            title:
                context.read<UserCubit>().userInfo != null
                    ? TextTitle(text: context.read<UserCubit>().userInfo!.name)
                    : Text(""),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "settings");
                },
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          body: Column(
            children: [
              Rectdata(
                title: "المكافات",
                prefixIcon: Icon(Icons.card_giftcard, size: 25),
                withArrow: false,
                ontap: () async {},
              ),
              Rectdata(
                title: "طلباتك",
                prefixIcon: SvgPicture.asset(
                  "assets/images/svg/orders.svg",
                  height: 25,
                ),
                withArrow: false,
                ontap: () {},
              ),
              Rectdata(
                title: "عن التطبيق",
                prefixIcon: Icon(Icons.info_outline),
                withArrow: false,
                ontap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'العشري استور',
                    applicationVersion: '1.0.0',
                    applicationIcon: FlutterLogo(size: 50),
                    applicationLegalese: '© 2025 Ahmed Salah',
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "تطبيق العشري ستور هو تطبيق مخصص لمحل العشري للمواد الغذائية يتيح للعملاء شراء احتياجاتهم اليومية أونلاين بسهولة وسرعة مع إمكانية التوصيل إلى المنزل.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
              Rectdata(
                prefixIcon: Icon(Icons.logout),
                withArrow: false,
                title: "تسجيل الخروج",
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('هل انت متاكد من تسجيل الخروج ؟'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // لإغلاق الديالوج
                            },
                            child: Text('إغلاق'),
                          ),

                          TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacementNamed(
                                // ignore: use_build_context_synchronously
                                context,
                                "login",
                              );

                              // لإغلاق الديالوج
                            },
                            child: Text('تسجيل الخروج'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              // IconButton(
              //   onPressed: () {
              //     context.read<UserCubit>().loadOneCategory("مشروبات");
              //   },
              //   icon: Icon(Icons.add, size: 400),
              // ),
            ],
          ),
        );
      },
    );
  }
}
