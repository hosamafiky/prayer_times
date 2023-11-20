import 'package:dartz/dartz.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/features/location/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Either<AppError, Location>> getUserLocation();
}
