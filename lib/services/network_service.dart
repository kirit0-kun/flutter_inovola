import 'package:flutterinovola/models/trip_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: "https://run.mocky.io/v3/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34")
  Future<TripResponseModel> getTripDetails();
}
