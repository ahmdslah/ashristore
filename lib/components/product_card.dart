import 'package:ashristore/const.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.name,
    required this.descreption,
    required this.imageUrl,
    required this.price,
  });

  final String name;
  final String descreption;
  final String imageUrl;
  final String price;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: (screenWidth * .9) * .85,
      width: (screenWidth * .95) / 2,
      ////////////////
      // color: const Color.fromARGB(255, 9, 254, 254),
      ////////////////
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(imageUrl),
              height: (screenWidth * .9) / 2,
            ),
            SizedBox(height: 5),
            Expanded(
              child: TextTitle(text: name, size: 18, fontcolor: kPColor),
            ),
            Expanded(
              child: TextTitle(text: descreption, size: 12, fontcolor: kPColor),
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  flex: 2,

                  child: Column(
                    children: [
                      TextTitle(
                        // textAlign: TextAlign,
                        text: price,
                        size: 18,
                        fontweight: FontWeight.bold,
                        fontcolor: kPColor,
                      ),
                      TextTitle(
                        // textAlign: TextAlign,
                        text: "جنيه",
                        size: 18,
                        fontweight: FontWeight.bold,
                        fontcolor: kPColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 5,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(kSColor),
                    ),
                    onPressed: () {},
                    child: TextTitle(
                      text: "اضف الي العربة",
                      size: 14,
                      fontweight: FontWeight.bold,
                      fontcolor: kPColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
