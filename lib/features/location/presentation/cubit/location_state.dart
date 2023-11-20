part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState({this.location, required this.error});

  final Location? location;
  final AppError? error;

  @override
  List<Object?> get props => [location, error];
}

class LocationInitial extends LocationState {
  const LocationInitial() : super(location: null, error: null);
}

class LocationUpdatedState extends LocationState {
  const LocationUpdatedState({Location? location, AppError? error}) : super(location: location, error: error);
}
