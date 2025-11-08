import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPref;

  init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  dynamic getData({required String key}) {
    return sharedPref.get(key);
  }

  Future<bool> saveList({required String key, required List value}) async {
    String jsonString = jsonEncode(value);
    print(jsonString);
    return await sharedPref.setString(key, jsonString);
  }

  List getList(String key) {
    String? codedList = sharedPref.getString(key);

    if (codedList == null || codedList.isEmpty) {
      return [];
    }

    try {
      return jsonDecode(codedList);
    } catch (e) {
      print('Error decoding JSON for key $key: $e');
      return [];
    }
  }

  Future<bool> saveListOfMap({required String key, required List value}) async {
    String jsonString = jsonEncode(value);
    return sharedPref.setString(key, jsonString);
  }

  List<Map<String, dynamic>> getListOfMap(String key) {
    try {
      String? codedList = sharedPref.getString(key);
      if (codedList == null || codedList.isEmpty) return [];
      return List<Map<String, dynamic>>.from(jsonDecode(codedList));
    } catch (e) {
      print('CacheHelper.getListOfMap error for key $key: $e');
      return [];
    }
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPref.setBool(key, value);
    } else if (value is String) {
      return await sharedPref.setString(key, value);
    } else if (value is int) {
      return await sharedPref.setInt(key, value);
    } else {
      return await sharedPref.setDouble(key, value);
    }
  }

  Future<bool> deleteData({required String key}) async {
    return await sharedPref.remove(key);
  }

  void printAllCache() {
    // final prefs = CacheHelper.sharedPref;؟
    final keys = sharedPref.getKeys();

    for (var key in keys) {
      print('$key : ${sharedPref.get(key)}');
    }
  }
}
