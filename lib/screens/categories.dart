import 'package:ashristore/components/category_card.dart';
import 'package:ashristore/components/category_page.dart';
import 'package:ashristore/const/const.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Categories extends StatelessWidget {
  Categories({super.key});
  String catNames = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is LoadCatSuccess) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      CategoryPage(catName: catNames, products: state.list),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                // من 0 إلى 1 (الشفافية)
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(
                milliseconds: 500,
              ), // مدة التأثير
            ),
          );
        } else if (state is LoadCatLoading) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: TextTitle(text: "الفئات الرئيسية")),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  catName: categories[index][catName]!,
                  imageUrl: categories[index][catImageUrl]!,
                  onTap: () {
                    catNames = categories[index][catName]!;
                    context.read<UserCubit>().loadOneCategory(
                      categories[index][catName]!,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
