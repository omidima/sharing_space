import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  var logger = Logger();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        'REQUEST ${options.method} => PATH: ${options.baseUrl}${options.path} DATA: ${options.data}'
        'HEADER ${options.headers}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(response);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR${err.error} => PATH: ${err.requestOptions.path} CODE: ${err.response?.statusCode} '
        'RESPONSE: ${err.response?.data}');
    return super.onError(err, handler);
  }
}
