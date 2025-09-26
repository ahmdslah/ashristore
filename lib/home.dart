import 'package:ashristore/components/product_card.dart';
import 'package:ashristore/excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List list = [];

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final data = await readFromGoogleSheet();
    setState(() {
      list = data; // خزّنا البيانات في المتغير
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, "login");
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],

        title: Text("بقالة العشري ترحب بك"),
      ),
      body:
          list.isEmpty
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
                    final product = list[index];
                    return ProductCard(
                      name: list[index]["Name"],
                      descreption: list[index]["Description"],
                      imageUrl: list[index]["image"],
                      price: list[index]["Price"],
                    );
                  },
                ),
              ),
    );
  }
}
