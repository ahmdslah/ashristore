import 'package:ashristore/components/rectData.dart';
import 'package:ashristore/text_title.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextTitle(text: "الاعدادات")),
      body: Column(
        children: [
          Rectdata(title: "بيانات الحساب", ontap: () {}, withArrow: true),
          Rectdata(title: "العناوين المحفوظة", ontap: () {}, withArrow: true),
          Rectdata(title: "تغيير الرقم السري", ontap: () {}, withArrow: true),
          Rectdata(title: "تفعيل الاشعارات", ontap: () {}, withArrow: true),
        ],
      ),
    );
  }
}
