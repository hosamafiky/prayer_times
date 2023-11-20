part of 'remaining_time_cubit.dart';

abstract class RemainingTimeState extends Equatable {
  final Prayer? nextPrayer;
  final Duration remainingTime;

  const RemainingTimeState({required this.nextPrayer, required this.remainingTime});

  @override
  List<Object?> get props => [nextPrayer, remainingTime];
}

class RemainingTimeInitial extends RemainingTimeState {
  const RemainingTimeInitial() : super(nextPrayer: null, remainingTime: const Duration(hours: 24));
}

class RemainingTimeChangedState extends RemainingTimeState {
  const RemainingTimeChangedState({required Prayer nextPrayer, required Duration remainingTime}) : super(nextPrayer: nextPrayer, remainingTime: remainingTime);
}
