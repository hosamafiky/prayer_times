import 'package:dartz/dartz.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/entities/prayer.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/repositories/prayer_repository.dart';

class GetPrayerTimesUsecase {
  final PrayerRepository prayerRepository;

  GetPrayerTimesUsecase(this.prayerRepository);

  Future<Either<AppError, DayPrayers>> execute({
    required int year,
    required int month,
    required int day,
    required double latitude,
    required double longitude,
  }) async =>
      await prayerRepository.getPrayerTimes(year: year, month: month, day: day, latitude: latitude, longitude: longitude);
}
