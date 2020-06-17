import 'package:dartz/dartz.dart';
import 'package:flutterinovola/core/failures.dart';

abstract class Repository<T> {
  Future<Either<T, Failure>> getData();
  void saveData(T obj);
}
