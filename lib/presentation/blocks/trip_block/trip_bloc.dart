import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterinovola/core/failures.dart';
import 'package:flutterinovola/entities/trip.dart';
import 'package:flutterinovola/presentation/blocks/trip_block/bloc.dart';
import 'package:flutterinovola/repositories/trip_repository.dart';

const String NETWORK_FAILURE_MESSAGE = 'Network Failure';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository repository;
  Trip _cachedTrip;

  TripBloc(this.repository) {
    this.add(GetTrip());
  }

  @override
  TripState get initialState => Empty();

  @override
  Stream<TripState> mapEventToState(
    TripEvent event,
  ) async* {
    if (event is GetTrip) {
      yield Loading();
      if (_cachedTrip == null) {
        final failureOrTrip = await repository.getData();
        yield* _eitherLoadedOrErrorState(failureOrTrip);
      } else {
        yield Loaded(trip: _cachedTrip);
      }
    } else if (event is SetLiked) {
      if (_cachedTrip != null) {
        _cachedTrip = _cachedTrip.setLiked(event.liked);
        yield Loaded(trip: _cachedTrip);
      } else {
        yield Error(message: NETWORK_FAILURE_MESSAGE);
      }
    }
  }

  Stream<TripState> _eitherLoadedOrErrorState(
    Either<Trip, Failure> failureOrTrip,
  ) async* {
    yield failureOrTrip.fold(
      (trip) {
        _cachedTrip = trip;
        return Loaded(trip: trip);
      },
      (failure) => Error(message: _mapFailureToMessage(failure)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
