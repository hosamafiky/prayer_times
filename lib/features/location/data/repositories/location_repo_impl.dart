import 'package:dartz/dartz.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/core/exceptions/exceptions.dart';
import 'package:json_serializable_learn/core/helpers/connection_helper.dart';
import 'package:json_serializable_learn/features/location/data/datasources/location_remote_datasource.dart';
import 'package:json_serializable_learn/features/location/domain/entities/location.dart';
import 'package:json_serializable_learn/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDatasource locationRemoteDatasource;

  LocationRepositoryImpl({required this.locationRemoteDatasource});

  @override
  Future<Either<AppError, Location>> getUserLocation() async {
    if (await ConnectionHelper.hasConnection()) {
      try {
        final location = await locationRemoteDatasource.getCurrentLocationData();
        return Right(location);
      } on ServerException catch (excep) {
        return Left(ServerError(message: excep.message));
      } on UnknownException catch (excep) {
        return Left(UnknownError(message: excep.message));
      }
    } else {
      return const Left(DisconnectedError());
    }
  }
}
