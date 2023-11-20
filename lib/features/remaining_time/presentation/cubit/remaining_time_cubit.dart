import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/entities/prayer.dart';

part 'remaining_time_state.dart';

class RemainingTimeCubit extends Cubit<RemainingTimeState> {
  RemainingTimeCubit() : super(const RemainingTimeInitial());

  onUpdateRemainingTime({required Prayer nextPrayer, required Duration remainingTime}) {
    emit(RemainingTimeChangedState(nextPrayer: nextPrayer, remainingTime: remainingTime));
  }
}
