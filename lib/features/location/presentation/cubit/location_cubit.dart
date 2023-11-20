import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/features/location/domain/entities/location.dart';
import 'package:json_serializable_learn/features/location/domain/usecases/get_location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetLocationUsecase getLocationUsecase;
  LocationCubit({required this.getLocationUsecase}) : super(const LocationInitial());

  void getLocationData() async {
    final either = await getLocationUsecase.execute();
    either.fold(
      (error) => emit(LocationUpdatedState(error: error)),
      (location) => emit(LocationUpdatedState(location: location)),
    );
  }
}
