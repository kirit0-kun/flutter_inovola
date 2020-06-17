import 'package:dartz/dartz.dart';

abstract class Failure {
  final String message;
  final int errorCode;

  Failure({this.message, this.errorCode = 0});
}

class NetworkFailure extends Failure {}
