import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> readFromGoogleSheet() async {
  // معرف الورقة (Sheet ID) من الرابط
  const sheetId = "1Y9gM-i8R2y28flgXzDtn5Rng08p4gQ9x";
  // اسم الـ sheet داخل الملف (sheet name)
  const sheetName = "Sheet1";

  // مفتاح الـ API (لازم تحط مفتاحك)
  const apiKey = "AIzaSyCG41PDLoFVVGnYieY2Af_0PDZnsETtep8";

  // رابط استعلام Google Sheets API
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
        obj[headers[j]] = row[j];
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
