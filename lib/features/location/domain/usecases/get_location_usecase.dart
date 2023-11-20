import 'package:dartz/dartz.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/features/location/domain/entities/location.dart';
import 'package:json_serializable_learn/features/location/domain/repositories/location_repository.dart';

class GetLocationUsecase {
  final LocationRepository locationRepository;

  GetLocationUsecase(this.locationRepository);

  Future<Either<AppError, Location>> execute() async => await locationRepository.getUserLocation();
}
