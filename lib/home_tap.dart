import 'package:ashristore/components/product_card.dart';
import 'package:ashristore/components/product_search_card.dart';
import 'package:ashristore/const/const.dart';
import 'package:ashristore/core/cache/cache_helper.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomeTap extends StatelessWidget {
  HomeTap({super.key});

  List list = CacheHelper().getListOfMap(productListCache);
  bool focused = false;
  List searchList = [];
  TextEditingController searchController = TextEditingController();

  search(String value) {
    List results =
        list.where((product) {
          String name = product['Name'].toString();
          return name.contains(value);
        }).toList();
    searchList = results;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..initializeData(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<UserCubit>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                SizedBox(width: 5),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        focused = true;
                        search(value);
                        context.read<UserCubit>().setState();
                      } else {
                        focused = false;
                        context.read<UserCubit>().setState();
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon:
                          searchController.text.isNotEmpty
                              ? IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  focused = false;
                                  context.read<UserCubit>().setState();
                                },
                                icon: Icon(Icons.close),
                              )
                              : Text(""),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                      hintText: "هل تبحث عن منتج معين ؟",
                    ),
                    controller: searchController,
                  ),
                ),
                SizedBox(width: 5),
                // Image(image: AssetImage("assets/images/logo.png"), height: 40),
              ],
            ),
            body:
                focused
                    ? SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < searchList.length; i++)
                            ProductSearchCard(
                              ontap: () {
                                print(searchList);
                              },
                              productName: searchList[i]['Name'],
                              price:
                                  searchList[i]['Price'] == "null"
                                      ? 0
                                      : int.parse(searchList[i]['Price']),
                              imageUrl:
                                  searchList[i]['image'] == "null"
                                      ? "https://simgbb.com/avatar/JWcX9Dx9CKrV.jpg"
                                      : searchList[i]['image'],
                            ),
                        ],
                      ),
                    )
                    : list.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 5,
                        ),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            addOnTap: () async {
                              final barcode =
                                  int.tryParse(list[index]["ID"] ?? "0") ?? 0;

                              await context.read<UserCubit>().updateUserCart(
                                barcode,
                                CacheHelper().getData(key: userEmail) ??
                                    "email",
                                CacheHelper().getList(userCart),
                              );
                            },

                            name: list[index]["Name"],
                            image:
                                list[index]["image"] == null
                                    ? Image(
                                      image: AssetImage(
                                        "assets/images/introPasswoed.png",
                                      ),
                                    )
                                    : Image(
                                      image: NetworkImage(list[index]["image"]),
                                    ),
                            price:
                                list[index]['Price'] == null
                                    ? 0
                                    : int.parse(list[index]["Price"]),
                            savePerc: 0,
                            points:
                                list[index]['Price'] == null
                                    ? 0
                                    : int.parse(list[index]["Price"]),
                          );
                        },
                      ),
                    ),

            // body: IconButton(
            //   onPressed: () async {
            //     List list = await readFromGoogleSheet();
            //     print("----------------------------------");
            //     print(list[0]['Price'].runtimeType);
            //     print(double.parse(list[0]['Price']).runtimeType);
            //     print("----------------------------------");
            //   },
            //   icon: Icon(Icons.add),
            // ),
          );
        },
      ),
    );
  }
}
