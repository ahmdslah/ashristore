import 'package:ashristore/core/api/end_points.dart';

class ErrorModel {
  final int? status;
  final String? message;

  ErrorModel({this.status, this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData[ApiKeys.status] is int ? jsonData[ApiKeys.status] : null,
      message:
          jsonData[ApiKeys.message] != null
              ? jsonData[ApiKeys.message].toString()
              : getMessage(jsonData[ApiKeys.errors]),
    );
  }
}

String getMessage(Map<String, dynamic> jsonData) {
  String message = '';
  jsonData.forEach((key, valueList) {
    for (var value in valueList) {
      message = "$message \n  $value  ";
    }
  });
  return message;
}
