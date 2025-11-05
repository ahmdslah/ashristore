import 'package:ashristore/const/const.dart';
import 'package:ashristore/core/cache/cache_helper.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/home_tap.dart';
import 'package:ashristore/screens/cart.dart';
import 'package:ashristore/screens/categories.dart';
import 'package:ashristore/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _taps = [HomeTap(), Categories(), Cart(), Profile()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..initState(),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          final cubit = context.read<UserCubit>();

          return Scaffold(
            body: _taps[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: cubit.changeIndex,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(fontSize: 14, fontFamily: "cairo"),
              unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontFamily: "cairo",
              ),

              // selectedItemColor: kSColor,
              unselectedItemColor: Colors.black,
              // showSelectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SvgPicture.asset(
                      "assets/images/svg/logo.svg",
                      height: 25,

                      color: cubit.currentIndex == 0 ? kSColor : Colors.black,
                    ),
                  ),
                  label: "تسوق",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SvgPicture.asset(
                      "assets/images/svg/cat.svg",
                      height: 25,
                      color: cubit.currentIndex == 1 ? kSColor : Colors.black,
                    ),
                  ),
                  label: "الفئات",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SvgPicture.asset(
                      "assets/images/svg/cart.svg",
                      height: 25,

                      color: cubit.currentIndex == 2 ? kSColor : Colors.black,
                    ),
                  ),
                  label: "العربة",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SvgPicture.asset(
                      "assets/images/svg/user.svg",
                      height: 25,

                      color: cubit.currentIndex == 3 ? kSColor : Colors.black,
                    ),
                  ),
                  label: "الحساب",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
