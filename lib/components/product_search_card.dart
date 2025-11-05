import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class ProductSearchCard extends StatelessWidget {
  const ProductSearchCard({
    super.key,
    required this.productName,
    required this.price,
    required this.imageUrl,
    this.ontap,
  });
  final String productName;
  final int price;
  final String imageUrl;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      title: TextTitle(text: productName, size: 14),
      trailing: TextTitle(text: "$price EGP", size: 16),
    );
  }
}
