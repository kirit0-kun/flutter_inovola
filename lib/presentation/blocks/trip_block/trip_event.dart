import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class TripEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTrip extends TripEvent {}

class SetLiked extends TripEvent {
  final bool liked;

  SetLiked(this.liked);

  @override
  List<Object> get props => [liked];
}

class ShareTrip extends TripEvent {}

class ReserveTrip extends TripEvent {
  final int reserveId;

  ReserveTrip(this.reserveId);

  @override
  List<Object> get props => [reserveId];
}
