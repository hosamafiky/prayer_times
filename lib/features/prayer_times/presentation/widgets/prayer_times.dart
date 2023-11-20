import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:json_serializable_learn/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:json_serializable_learn/features/remaining_time/presentation/cubit/remaining_time_cubit.dart';
import 'package:json_serializable_learn/features/remaining_time/presentation/widgets/timer_widget.dart';
import 'package:json_serializable_learn/services/local_notifications.dart';

import '../../domain/entities/prayer.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemainingTimeCubit, RemainingTimeState>(
      buildWhen: (previous, current) => previous.nextPrayer != current.nextPrayer,
      builder: (context, timeState) {
        return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
          builder: (context, prayersState) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _PrayerSection(
                  prayersState.dayPrayers?.timings.fajr,
                  isTheNext: timeState.nextPrayer == prayersState.dayPrayers?.timings.fajr,
                ),
                _PrayerSection(
                  prayersState.dayPrayers?.timings.sunrise,
                  isTheNext: timeState.nextPrayer == prayersState.dayPrayers?.timings.sunrise,
                ),
                _PrayerSection(
                  prayersState.dayPrayers?.timings.dhuhr,
                  isTheNext: timeState.nextPrayer == prayersState.dayPrayers?.timings.dhuhr,
                ),
                _PrayerSection(
                  prayersState.dayPrayers?.timings.asr,
                  isTheNext: timeState.nextPrayer == prayersState.dayPrayers?.timings.asr,
                ),
                _PrayerSection(
                  prayersState.dayPrayers?.timings.maghrib,
                  isTheNext: timeState.nextPrayer == prayersState.dayPrayers?.timings.maghrib,
                ),
                _PrayerSection(
                  prayersState.dayPrayers?.timings.isha,
                  isTheNext: timeState.nextPrayer == prayersState.dayPrayers?.timings.isha,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _PrayerSection extends StatelessWidget {
  const _PrayerSection(this.prayer, {this.isTheNext = false});

  final Prayer? prayer;
  final bool isTheNext;

  @override
  Widget build(BuildContext context) {
    LocalNotificationService().getNotifications();
    if (prayer == null) {
      return const Offstage();
    } else {
      return Container(
        padding: isTheNext ? const EdgeInsets.all(16).copyWith(left: 32) : const EdgeInsets.all(16),
        margin: isTheNext ? null : const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: isTheNext ? const Color(0xFF4489fe) : Colors.white,
          boxShadow: isTheNext
              ? [
                  const BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    color: Colors.black26,
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prayer!.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: isTheNext ? Colors.white : null,
                  ),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                DateFormat.jm().format(prayer!.time).toLowerCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: isTheNext ? Colors.white : Colors.grey[400],
                    ),
              ),
            ),
            if (isTheNext) ...[
              const SizedBox(height: 12),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: TimerWidget(textColor: Colors.white.withOpacity(0.6))),
            ],
          ],
        ),
      );
    }
  }
}
