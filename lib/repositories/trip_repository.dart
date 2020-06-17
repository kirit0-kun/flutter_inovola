import 'package:dartz/dartz.dart';
import 'package:flutterinovola/core/data_source.dart';
import 'package:flutterinovola/core/failures.dart';
import 'package:flutterinovola/core/repository.dart';
import 'package:flutterinovola/entities/trip.dart';
import 'package:flutterinovola/models/trip_model.dart';

class TripRepository extends Repository<Trip> {
  final DataSource<TripResponseModel> remoteDataSource;

  TripRepository(this.remoteDataSource);

  @override
  Future<Either<Trip, Failure>> getData() async {
    try {
      final remoteData = await remoteDataSource.getData();
      return Left(remoteData);
    } on Exception {
      return Right(NetworkFailure());
    }
  }

  @override
  void saveData(Trip obj) {}
}
