import 'package:flutterinovola/models/trip_model.dart';

abstract class DataSource<T> {
  Future<T> getData();
  void saveData(T obj);
}
