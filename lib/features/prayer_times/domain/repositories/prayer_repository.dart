import 'package:dartz/dartz.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/entities/prayer.dart';

abstract class PrayerRepository {
  Future<Either<AppError, DayPrayers>> getPrayerTimes({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  });
}
