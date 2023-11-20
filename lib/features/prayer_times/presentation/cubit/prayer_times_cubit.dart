import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_serializable_learn/core/exceptions/errors.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/entities/prayer.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/usecases/get_prayer_times_usecase.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetPrayerTimesUsecase getPrayerTimesUsecase;
  PrayerTimesCubit({
    required this.getPrayerTimesUsecase,
  }) : super(const PrayerTimesInitialState());

  void getDayPrayerTimes({required double latitude, required double longitude}) async {
    final either = await getPrayerTimesUsecase.execute(
      year: DateTime.now().year,
      month: DateTime.now().month,
      latitude: latitude,
      longitude: longitude,
    );

    either.fold(
      (error) => emit(PrayerTimesUpdatedState(error: error)),
      (dayPrayers) => emit(PrayerTimesUpdatedState(dayPrayers: dayPrayers)),
    );
  }
}
