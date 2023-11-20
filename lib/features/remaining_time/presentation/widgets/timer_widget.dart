import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/remaining_time_cubit.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key, this.textColor = Colors.black});

  final Color textColor;

  String convertToArabicNumber(String number) {
    String res = '';

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var element in number.characters) {
      res += arabics[int.parse(element)];
    }
    return res;
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours.remainder(12).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    return '$hours hour${int.parse(hours) > 1 ? 's' : ''} $minutes minute${int.parse(minutes) > 1 ? 's' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemainingTimeCubit, RemainingTimeState>(
      buildWhen: (previous, current) => previous.remainingTime != current.remainingTime,
      builder: (context, state) {
        return Text(
          'Time until next prayer : ${formatDuration(state.remainingTime)}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 11,
                color: textColor,
              ),
        );
      },
    );
  }
}
