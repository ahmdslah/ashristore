import 'package:ashristore/const/const.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class ProductCartCard extends StatelessWidget {
  const ProductCartCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.count,
  });

  final String name;
  final String price;
  final String imageUrl;
  final int count;
  @override
  Widget build(BuildContext context) {
    int newPrice = int.parse(price);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(minRadius: 35, backgroundImage: NetworkImage(imageUrl)),
          // SizedBox(width: 15),
          SizedBox(
            width: 160,
            child: TextTitle(text: name, fontcolor: kPColor, size: 22),
          ),
          Column(
            children: [
              TextTitle(
                text: "${newPrice * count} EGP",
                size: 18,
                fontweight: FontWeight.bold,
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.add_circle)),
                  TextTitle(
                    text: "$count",
                    size: 18,
                    fontweight: FontWeight.bold,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
