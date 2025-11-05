import 'package:ashristore/components/product_card.dart';
import 'package:ashristore/const/const.dart';
import 'package:ashristore/core/cache/cache_helper.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.products,
    required this.catName,
  });
  final List products;
  final String catName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: TextTitle(text: catName))),
      body:
          products.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 5,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      addOnTap: () async {
                        final barcode =
                            int.tryParse(products[index]["ID"] ?? "0") ?? 0;

                        await context.read<UserCubit>().updateUserCart(
                          barcode,
                          CacheHelper().getData(key: userEmail) ?? "email",
                          CacheHelper().getList(userCart),
                        );

                        print("✅ تم تحديث العربة بنجاح");
                        print(CacheHelper().getList(userCart));
                      },
                      name: products[index]["Name"],
                      image:
                          products[index]["image"] == null
                              ? Image(
                                image: AssetImage(
                                  "assets/images/introPasswoed.png",
                                ),
                              )
                              : Image(
                                image: NetworkImage(products[index]["image"]),
                              ),
                      price:
                          products[index]['Price'] == null
                              ? 0
                              : int.parse(products[index]["Price"]),
                      savePerc: 0,
                      points:
                          products[index]['Price'] == null
                              ? 0
                              : int.parse(products[index]["Price"]),
                    );
                  },
                ),
              )
              : Center(
                child: TextTitle(
                  text: "لايوجد منتجات لعرضها",
                  size: 24,
                  fontweight: FontWeight.w500,
                ),
              ),
    );
  }
}
