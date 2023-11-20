// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prayer_times_cubit.dart';

abstract class PrayerTimesState extends Equatable {
  const PrayerTimesState({required this.dayPrayers, required this.error});

  final DayPrayers? dayPrayers;
  final AppError? error;

  @override
  List<Object?> get props => [dayPrayers, error];
}

class PrayerTimesInitialState extends PrayerTimesState {
  const PrayerTimesInitialState() : super(dayPrayers: null, error: null);
}

class PrayerTimesUpdatedState extends PrayerTimesState {
  const PrayerTimesUpdatedState({DayPrayers? dayPrayers, AppError? error}) : super(dayPrayers: dayPrayers, error: error);
}
