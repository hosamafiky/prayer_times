import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:json_serializable_learn/core/helpers/dio_helper.dart';
import 'package:json_serializable_learn/features/prayer_times/data/models/prayer_model.dart';

import '../../../../core/exceptions/exceptions.dart';

abstract class PrayersRemoteDatasource {
  Future<DayPrayersModel> getDayPrayerTimes({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  });
}

class PrayersRemoteDatasourceImpl implements PrayersRemoteDatasource {
  final DioHelper dioHelper;

  PrayersRemoteDatasourceImpl({required this.dioHelper});

  @override
  Future<DayPrayersModel> getDayPrayerTimes({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  }) async {
    final query = {"latitude": latitude, "longitude": longitude, "method": 2};
    try {
      final response = await dioHelper.getData('https://api.aladhan.com/v1/calendar/$year/$month', queryParameters: query);
      return List<DayPrayersModel>.from(response.data['data'].map((e) => DayPrayersModel.fromJson(e)))
          .firstWhere((element) => DateFormat('dd-MM-yyyy').format(DateTime.now()) == element.date.gregorian.date);
    } on DioException catch (error) {
      throw ServerException(message: error.response?.data['message']);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
