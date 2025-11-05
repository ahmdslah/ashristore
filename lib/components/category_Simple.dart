import 'package:ashristore/const/const.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class CategorySimple extends StatelessWidget {
  const CategorySimple({
    super.key,
    this.title = "Category Title",
    required this.route,
  });
  final String? title;
  final String route;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              TextTitle(text: title!, size: 25, fontcolor: kPColor),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, route);
                },
                child: Text("See all"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
