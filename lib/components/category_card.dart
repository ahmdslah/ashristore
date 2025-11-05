import 'package:ashristore/const/const.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.catName,
    required this.imageUrl,
    this.onTap,
  });
  final String catName;
  final String imageUrl;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.8),
            Colors.grey.shade100,
            Colors.white,
          ],
          stops: [0.0, 0.4, 0.8, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 10,
            spreadRadius: -2,
            offset: Offset(-3, -3),
          ),
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: -2,
            offset: Offset(3, 3),
          ),
        ],

        // color: const Color.fromARGB(211, 143, 142, 142),
        borderRadius: BorderRadius.circular(25),
      ),
      width: 180,
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Column(
            spacing: 15,
            children: [
              Image(height: 100, image: NetworkImage(imageUrl)),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: TextTitle(
                  text: catName,
                  fontcolor: kPColor,
                  size: 20,
                  fontweight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
