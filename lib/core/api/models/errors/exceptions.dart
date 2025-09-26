import 'package:ashristore/core/api/models/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerExeption implements Exception {
  final ErrorModel errorModel;

  ServerExeption({required this.errorModel});
}

void handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerExeption(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.sendTimeout:
      throw ServerExeption(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.receiveTimeout:
      throw ServerExeption(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.badCertificate:
      throw ServerExeption(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.cancel:
      throw ServerExeption(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.connectionError:
      throw ServerExeption(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerExeption(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerExeption(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        default:
          throw ServerExeption(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
      }
  }
}
