import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterinovola/entities/trip.dart';

@immutable
abstract class TripState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends TripState {}

class Loading extends TripState {}

class Loaded extends TripState {
  final Trip trip;
  Loaded({@required this.trip});
  @override
  List<Object> get props => [trip];
}

class Reserved extends TripState {
  final Trip trip;
  final int reserveId;

  Reserved({@required this.trip, @required this.reserveId});

  @override
  List<Object> get props => [trip, reserveId];
}

class Error extends TripState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
