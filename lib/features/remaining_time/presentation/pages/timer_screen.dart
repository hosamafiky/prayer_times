import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_serializable_learn/core/utils/snackbar.dart';
import 'package:json_serializable_learn/features/location/presentation/cubit/location_cubit.dart';
import 'package:json_serializable_learn/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:json_serializable_learn/features/prayer_times/presentation/widgets/prayer_times.dart';
import 'package:json_serializable_learn/services/local_notifications.dart';

import '../../../prayer_times/domain/entities/prayer.dart';
import '../cubit/remaining_time_cubit.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key, required this.title});

  final String title;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer timer;
  @override
  void initState() {
    Future.wait([initService(), removeCachedNotifications(), getActiveNotifications()]);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> initService() async => await LocalNotificationService().initialize();
  Future<void> removeCachedNotifications() async => await LocalNotificationService().removeNotifications();
  Future<void> getActiveNotifications() async => await LocalNotificationService().getNotifications();
  Duration _calculateDifference(DateTime time) => time.difference(DateTime.now());

  Prayer _getTheNextPrayer(DayPrayers dayPrayers) {
    final now = DateTime.now();
    if (dayPrayers.timings.fajr.time.isAfter(now)) {
      return dayPrayers.timings.fajr;
    } else if (dayPrayers.timings.dhuhr.time.isAfter(now)) {
      return dayPrayers.timings.dhuhr;
    } else if (dayPrayers.timings.asr.time.isAfter(now)) {
      return dayPrayers.timings.asr;
    } else if (dayPrayers.timings.maghrib.time.isAfter(now)) {
      return dayPrayers.timings.maghrib;
    } else if (dayPrayers.timings.isha.time.isAfter(now)) {
      return dayPrayers.timings.isha;
    } else {
      return dayPrayers.timings.fajr.copyWith(time: dayPrayers.timings.fajr.time.add(const Duration(days: 1)));
    }
  }

  void scheduleNextPrayer(Prayer prayer) async {
    await LocalNotificationService().schedule(
      title: 'صلاة ${prayer.arTitle}',
      body: 'باقي على صلاة ${prayer.arTitle} ١٠ دقائق',
      time: prayer.time.subtract(const Duration(minutes: 10)),
    );

    if (context.mounted) {
      showSnackBar(context, data: 'تم عمل إخطار ${prayer.time.subtract(const Duration(minutes: 10))}');
    }

    await LocalNotificationService().schedule(
      title: 'صلاة ${prayer.arTitle}',
      body: 'حان الان موعد صلاة ${prayer.arTitle}',
      time: prayer.time,
    );

    if (context.mounted) {
      showSnackBar(context, data: 'تم عمل إخطار ${prayer.time}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RemainingTimeCubit, RemainingTimeState>(
          listenWhen: (prevoius, current) => prevoius.nextPrayer != current.nextPrayer,
          listener: (context, state) {
            if (state is RemainingTimeChangedState) {
              scheduleNextPrayer(_getTheNextPrayer(context.read<PrayerTimesCubit>().state.dayPrayers!));
            }
          },
        ),
        BlocListener<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state.error != null) {
              log(state.error!.message);
            } else {
              context.read<PrayerTimesCubit>().getDayPrayerTimes(
                    latitude: context.read<LocationCubit>().state.location!.latitude,
                    longitude: context.read<LocationCubit>().state.location!.longitude,
                  );
            }
          },
        ),
        BlocListener<PrayerTimesCubit, PrayerTimesState>(
          listener: (context, state) {
            if (state.dayPrayers != null) {
              timer = Timer.periodic(
                const Duration(seconds: 1),
                (_) => context.read<RemainingTimeCubit>().onUpdateRemainingTime(
                      nextPrayer: _getTheNextPrayer(state.dayPrayers!),
                      remainingTime: _calculateDifference(_getTheNextPrayer(state.dayPrayers!).time),
                    ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 120,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
                builder: (context, state) {
                  return Text(
                    state.dayPrayers != null
                        ? '${state.dayPrayers!.date.hijri.day} ${state.dayPrayers!.date.hijri.month.en} ${context.read<PrayerTimesCubit>().state.dayPrayers!.date.hijri.year} / ${context.read<PrayerTimesCubit>().state.dayPrayers!.date.readable}'
                        : '',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 15),
                  );
                },
              ),
              const SizedBox(height: 8),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  return Text(
                    state.location != null ? '${state.location!.countryName} ${state.location!.locality}' : '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        body: const PrayerTimesWidget(),
      ),
    );
  }
}
