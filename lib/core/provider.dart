import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:share_space/core/const/config.dart';

part 'provider.g.dart';


@RestApi(baseUrl: API_ADDRESS)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/tasks")
  Future<List<String>> getTasks();
}