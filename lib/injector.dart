import 'package:flutterinovola/presentation/blocks/trip_block/bloc.dart';
import 'package:flutterinovola/services/network_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'data_sources/remote_data_source.dart';
import 'repositories/trip_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => TripBloc(sl()),
  );

  // Repository
  sl.registerLazySingleton<TripRepository>(
    () => TripRepository(sl<TripRemoteDataSourceImpl>()),
  );

  // Data sources
  sl.registerLazySingleton<TripRemoteDataSourceImpl>(
    () => TripRemoteDataSourceImpl(sl()),
  );

  // Services
  sl.registerLazySingleton(() {
    final dio = Dio(); // Provide a dio instance
    return dio;
  });
  sl.registerLazySingleton(() {
    final client = RestClient(sl());
    return client;
  });
}
