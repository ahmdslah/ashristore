import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    options.headers['Accept-Language'] = "ar";
    options.headers['X-Api-Key'] = "9637345d5b0011083cbc73c541b66ed49637345d";
  }
}
