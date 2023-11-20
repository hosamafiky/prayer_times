import 'package:dartz/dartz.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/core/exceptions/exceptions.dart';
import 'package:json_serializable_learn/core/helpers/connection_helper.dart';
import 'package:json_serializable_learn/features/prayer_times/data/datasources/prayers_remote_datasource.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/entities/prayer.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/repositories/prayer_repository.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final PrayersRemoteDatasource prayersRemoteDatasource;

  PrayerRepositoryImpl({required this.prayersRemoteDatasource});
  @override
  Future<Either<AppError, DayPrayers>> getPrayerTimes({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  }) async {
    if (await ConnectionHelper.hasConnection()) {
      try {
        final prayers = await prayersRemoteDatasource.getDayPrayerTimes(year: year, month: month, latitude: latitude, longitude: longitude);
        return Right(prayers);
      } on ServerException catch (exception) {
        return Left(ServerError(message: exception.message));
      } on UnknownException catch (exception) {
        return Left(UnknownError(message: exception.message));
      }
    } else {
      return const Left(DisconnectedError());
    }
  }
}
