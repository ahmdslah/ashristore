import 'package:ashristore/const/const.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.savePerc,
    required this.points,
    this.addOnTap,
  });

  final String name;
  final Image image;
  final int price;
  final int savePerc;
  final int points;
  final Function()? addOnTap;

  @override
  Widget build(BuildContext context) {
    double newPrice = price - (price * savePerc * .01);
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: (screenWidth * .9) * .75,
      width: (screenWidth * .95) / 2,

      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image,
            Container(
              // color: kPColor,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(164, 218, 218, 218),
                borderRadius: BorderRadius.circular(25),
              ),
              height: (screenWidth * .9) * .50,
              child: Stack(
                children: [
                  Center(child: image),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: addOnTap,
                      icon: Icon(Icons.add),
                      color: kSColor,
                      iconSize: 30,
                      style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(5),
                        shadowColor: WidgetStatePropertyAll(kPColor),
                        backgroundColor: WidgetStatePropertyAll(
                          const Color.fromARGB(226, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Text(
                      " Points  $points",
                      style: TextStyle(
                        fontFamily: "cairo",

                        backgroundColor: kSColor,
                      ),
                    ),
                  ),
                  savePerc > 0
                      ? Positioned(
                        left: 10,
                        top: 35,
                        child: Text(
                          "Save $savePerc%",
                          style: TextStyle(
                            fontFamily: "cairo",

                            backgroundColor: kSColor,
                          ),
                        ),
                      )
                      : Container(),
                ],
              ),
            ),
            // SizedBox(height: 5),
            TextTitle(
              text: name,
              size: 14,
              fontcolor: Colors.black,
              fontweight: FontWeight.bold,
            ),
            savePerc < 1
                ? TextTitle(
                  text: "${price.toInt()} جنيهََا",
                  size: 18,
                  fontcolor: kPColor,
                  fontweight: FontWeight.bold,
                )
                : Row(
                  children: [
                    TextTitle(
                      text: "${newPrice.toInt()} جنيهََا",
                      size: 16,
                      fontcolor: Colors.redAccent,
                      fontweight: FontWeight.bold,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${price.toInt()} جنيهََا",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
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
