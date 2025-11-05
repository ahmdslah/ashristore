import 'package:ashristore/const/const.dart';
import 'package:ashristore/excel/excel.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, "login");
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                list = await readFromGoogleSheet();
                print("=============================");
                print(list[0]);
                print("=============================");
                setState(() {});
              },
              icon: Icon(Icons.add),
            ),
            // for (int i = 0; i < list.length; i++)
            ListTile(
              title: Text(list[0]["Name"]),
              subtitle: Text(list[0]["Description"]),
              leading: Text("\$ ${list[0]["Price"]}"),
              trailing: Image(
                image: NetworkImage(list[0]["image"]),
                height: 30,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: (screenWidth * .9) * .85,
                  width: (screenWidth * .95) / 2,
                  ////////////////
                  // color: const Color.fromARGB(255, 9, 254, 254),
                  ////////////////
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage(list[0]["image"]),
                          height: (screenWidth * .9) / 2,
                        ),
                        SizedBox(height: 5),
                        TextTitle(
                          text: list[0]["Name"],
                          size: 20,
                          fontcolor: kPColor,
                        ),
                        TextTitle(
                          text: list[0]["Description"],
                          size: 12,
                          fontcolor: kPColor,
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,

                              child: TextTitle(
                                // textAlign: TextAlign,
                                text: list[0]["Price"] + " جنيه",
                                size: 18,
                                fontweight: FontWeight.bold,
                                fontcolor: kPColor,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 5,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    kSColor,
                                  ),
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
                ),
                SizedBox(width: screenWidth * .05),

                SizedBox(
                  height: (screenWidth * .9) * .85,
                  width: (screenWidth * .95) / 2,
                  ////////////////
                  // color: const Color.fromARGB(255, 9, 254, 254),
                  ////////////////
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage(list[0]["image"]),
                          height: (screenWidth * .9) / 2,
                        ),
                        SizedBox(height: 5),
                        TextTitle(
                          text: list[0]["Name"],
                          size: 20,
                          fontcolor: kPColor,
                        ),
                        TextTitle(
                          text: list[0]["Description"],
                          size: 12,
                          fontcolor: kPColor,
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,

                              child: TextTitle(
                                // textAlign: TextAlign,
                                text: list[0]["Price"] + " جنيه",
                                size: 18,
                                fontweight: FontWeight.bold,
                                fontcolor: kPColor,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 5,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    kSColor,
                                  ),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
