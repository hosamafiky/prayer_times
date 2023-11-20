// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_serializable_learn/core/helpers/dio_helper.dart';
import 'package:json_serializable_learn/features/location/data/datasources/location_remote_datasource.dart';
import 'package:json_serializable_learn/features/location/data/repositories/location_repo_impl.dart';
import 'package:json_serializable_learn/features/location/domain/usecases/get_location_usecase.dart';
import 'package:json_serializable_learn/features/location/presentation/cubit/location_cubit.dart';
import 'package:json_serializable_learn/features/prayer_times/data/datasources/prayers_remote_datasource.dart';
import 'package:json_serializable_learn/features/prayer_times/data/repositories/prayer_repository_impl.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:json_serializable_learn/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:json_serializable_learn/features/remaining_time/presentation/cubit/remaining_time_cubit.dart';
import 'package:json_serializable_learn/features/remaining_time/presentation/pages/timer_screen.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart';

void main() {
  tzl.initializeTimeZones();
  setLocalLocation(getLocation('Africa/Cairo'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => PrayerTimesCubit(
            getPrayerTimesUsecase: GetPrayerTimesUsecase(
              PrayerRepositoryImpl(
                prayersRemoteDatasource: PrayersRemoteDatasourceImpl(
                  dioHelper: DioHelper(),
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => LocationCubit(
            getLocationUsecase: GetLocationUsecase(
              LocationRepositoryImpl(
                locationRemoteDatasource: LocationRemoteDatasourceImpl(),
              ),
            ),
          )..getLocationData(),
        ),
        BlocProvider(create: (context) => RemainingTimeCubit()),
      ],
      child: MaterialApp(
        title: 'مواقيت الصلاة',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFebeff2),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TimerScreen(title: 'Prayer Times'),
      ),
    );
  }
}
