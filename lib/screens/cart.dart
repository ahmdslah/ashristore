import 'package:ashristore/components/product_cart_card.dart';
import 'package:ashristore/const/const.dart';
import 'package:ashristore/core/cache/cache_helper.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/text_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  Cart({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        List pCart = CacheHelper().getListOfMap(cartListCache);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async {
                  await cubit.users.doc(cubit.userInfo!.email).set({
                    userCart: [],
                  }, SetOptions(merge: true));
                  CacheHelper().deleteData(key: cartListCache);
                  CacheHelper().deleteData(key: userCart);
                  final doc =
                      await FirebaseFirestore.instance
                          .collection(userCollection)
                          .doc(cubit.userInfo!.email.trim().toLowerCase())
                          .get();
                  print(CacheHelper().getListOfMap(cartListCache));

                  print(doc[userCart]);
                  CacheHelper().printAllCache();
                  cubit.setState();
                },
                icon: Icon(Icons.delete),
              ),
            ],
            title: TextTitle(text: "عربة التسوق"),
          ),
          body:
              pCart.isEmpty
                  ? Center(
                    child: TextTitle(
                      text: "قم باضافة منتجات الي العربة",
                      fontcolor: kPColor,
                      size: 25,
                    ),
                  )
                  : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          TextTitle(
                            text: "المبلغ الاجمالي:",
                            size: 24,
                            fontcolor: kPColor,
                            fontweight: FontWeight.bold,
                          ),
                          TextTitle(
                            size: 24,
                            fontcolor: kPColor,
                            fontweight: FontWeight.bold,
                            text:
                                CacheHelper()
                                    .getData(key: totalPriceCache)
                                    .toString(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    kSColor,
                                  ),
                                ),
                                onPressed: () {
                                  context.read<UserCubit>().changeIndex(0);
                                },
                                child: TextTitle(
                                  text: "متابعة التسوق",
                                  fontcolor: kPColor,
                                  fontweight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    kSColor,
                                  ),
                                ),
                                onPressed: () {},
                                child: TextTitle(
                                  text: "اتمام الشراء",
                                  fontcolor: kPColor,
                                  fontweight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < pCart.length; i++)
                                ProductCartCard(
                                  count: pCart[i][pCount] ?? 0,
                                  imageUrl:
                                      pCart[i][pImageUrl] ??
                                      "https://i.ibb.co/p6gwdfdq/download.jpg",
                                  name: pCart[i][pName] ?? " ",
                                  price: pCart[i][pPrice] ?? "0",
                                ),
                            ],
                          ),
                        ),
                      ),

                      // ProductSearchCard(
                      //   productName: "اندومي حار كبير ",
                      //   price: 10,
                      //   imageUrl:
                      //       "https://play-lh.googleusercontent.com/6MtUcsS5i95q92P6NbHTGzJT6hs6cJANaMHXfW5nco5_hDOnF1AC3A5lgH3Ik3MARAry",
                      //   ontap: () async {
                      //     // context.read<UserCubit>().adduser(
                      //     //   "fName",
                      //     //   "lName",
                      //     //   "password",
                      //     //   "email",
                      //     //   "121212121221",
                      //     //   DateTime(2025),
                      //     // );
                      //     // // context.read<UserCubit>().updateUserCart(12, "email", [1, 2, 3]);
                      //     // UserModel user = await context.read<UserCubit>().getUserInfo();
                      //     // print(user.cart);
                      //     // print(user.email);
                      //     // print(user.name);
                      //     // print(context.read<UserCubit>().user);
                      //     await context.read<UserCubit>().initState();
                      //     List list = context.read<UserCubit>().showCart();
                      //     print(list);
                      //   },
                      // ),

                      // for (int i = 0; i < context.read<UserCubit>().cart.length; i++)
                      //   ProductSearchCard(
                      //     productName: context.read<UserCubit>().cart[i][pName],
                      //     price: 0,
                      //     imageUrl: "imageUrl",
                      //   ),
                    ],
                  ),
        );
      },
    );
  }
}
