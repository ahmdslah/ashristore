import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> readFromGoogleSheet() async {
  final url = Uri.parse(
    "https://sheets.googleapis.com/v4/spreadsheets/1ORbdCJJK7szdsrjdWZC2W8Sa9EjkGjc7ueeocAW91r0/values/Sheet1?key=AIzaSyCG41PDLoFVVGnYieY2Af_0PDZnsETtep8",
  );

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // البيانات تكون في data["values"]
    List<dynamic> rows = data["values"];
    // افترض أن الصف الأول هو رؤوس الأعمدة
    List<String> headers = rows[0].cast<String>();

    List<Map<String, dynamic>> list = [];
    for (var i = 1; i < rows.length; i++) {
      var row = rows[i];
      Map<String, dynamic> obj = {};
      for (var j = 0; j < headers.length; j++) {
        if (j < row.length &&
            row[j] != null &&
            row[j].toString().trim().isNotEmpty) {
          obj[headers[j]] = row[j];
        } else {
          obj[headers[j]] = null;
        }
      }
      list.add(obj);
    }
    print(list); // هتلاقي قائمة من الخرائط تمثل البيانات
    return list;
  } else {
    print("Failed to fetch sheet: ${response.statusCode}");
    return [];
  }
}

Future<List> readCategoriesFromGoogleSheet() async {
  final url = Uri.parse(
    "https://sheets.googleapis.com/v4/spreadsheets/1ORbdCJJK7szdsrjdWZC2W8Sa9EjkGjc7ueeocAW91r0/values/Sheet2!A2:B?key=AIzaSyCG41PDLoFVVGnYieY2Af_0PDZnsETtep8",
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    List categories = data["values"] ?? [];

    print("✅ عدد الفئات: ${categories.length}");
    print(categories);
    print(categories.runtimeType);

    return categories;
  } else {
    print("❌ Failed to fetch sheet: ${response.statusCode}");
    return [];
  }
}
