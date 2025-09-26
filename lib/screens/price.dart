import 'dart:async';

import 'package:ashristore/const.dart';
import 'package:ashristore/core/api/models/price_model.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/screens/next_button.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Price extends StatelessWidget {
  Price({super.key, this.priceModel});
  PriceModel? priceModel;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is GetPriceSuccess) {
          timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
            context.read<UserCubit>().getGoldPrice();
          });
          priceModel = state.priceModel;
          print("=----------------------------------------------");
          print(priceModel);
          print("-------------------------------------------");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: TextTitle(
              text: "سعر الذهب لحظه بلحظه",
              size: 20,
              fontweight: FontWeight.bold,
              fontcolor: kPColor,
            ),
          ),
          body: Column(
            children: [
              NextButton(
                text: "تحديث",
                onPressed: () {
                  context.read<UserCubit>().getGoldPrice();
                },
              ),
              priceModel == null
                  ? Container()
                  : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextTitle(
                            text: "سعر الذهب",
                            size: 20,
                            fontweight: FontWeight.bold,
                          ),
                          TextTitle(
                            text: "الجنية",
                            size: 20,
                            fontweight: FontWeight.bold,
                          ),
                          TextTitle(
                            text: "الدولار",
                            size: 20,
                            fontweight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextTitle(
                            text: "اونصة الذهب",
                            size: 20,
                            fontweight: FontWeight.bold,
                          ),
                          TextTitle(
                            text: "${priceModel!.ozPriceEGP!.toInt()}",
                            size: 20,
                            fontweight: FontWeight.bold,
                          ),
                          TextTitle(
                            text: "${priceModel!.ozPriceUSd}",
                            size: 20,
                            fontweight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
            ],
          ),
        );
      },
    );
  }
}
