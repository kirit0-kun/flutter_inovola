import 'package:dartz/dartz.dart';
import 'package:flutterinovola/core/data_source.dart';
import 'package:flutterinovola/core/failures.dart';
import 'package:flutterinovola/models/trip_model.dart';
import 'package:flutterinovola/services/network_service.dart';

class TripRemoteDataSourceImpl extends DataSource<TripResponseModel> {
  final RestClient client;

  TripRemoteDataSourceImpl(this.client);

  @override
  Future<TripResponseModel> getData() async {
    return client.getTripDetails();
  }

  @override
  void saveData(TripResponseModel trip) {}
}
