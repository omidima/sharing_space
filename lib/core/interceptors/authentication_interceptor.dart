import 'package:dio/dio.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["X-Parse-Application-Id"] =
        "vaCD0jtOIq0pjw3TcraHmkaWMng66rHoTqZowGpI";
    options.headers["X-Parse-REST-API-Key"] =
        "I8VVJ9KVnS1n7NEKsc5AjdiPpAba9ulsdZEFW9kj";
    options.headers["X-Parse-Revocable-Session"] = "1";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 401) super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }
}
