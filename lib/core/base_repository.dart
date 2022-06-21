import 'package:dio/dio.dart';
import 'package:share_space/core/interceptors/authentication_interceptor.dart';
import 'package:share_space/core/interceptors/logging_interceptor.dart';
import 'package:share_space/core/provider.dart';

abstract class BaseRepository {
  late RestClient restProvider;

  BaseRepository() {
    final Dio dio = Dio();
    dio.interceptors
        .addAll([LoggingInterceptor(), AuthenticationInterceptor()]);

    restProvider = RestClient(dio);
  }
}
