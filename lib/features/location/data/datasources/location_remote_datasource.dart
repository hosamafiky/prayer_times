import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_serializable_learn/core/exceptions/exceptions.dart';

import '../models/location_model.dart';

abstract class LocationRemoteDatasource {
  Future<LocationModel> getCurrentLocationData();
}

class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  @override
  Future<LocationModel> getCurrentLocationData() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const ServerException(message: 'Location permissions are denied');
        }
        if (permission == LocationPermission.deniedForever) {
          throw const ServerException(message: 'Location permissions are permanently denied, we cannot request permissions.');
        }
      }
      try {
        try {
          final response = await Dio().get('https://api.bigdatacloud.net/data/reverse-geocode-client');
          return LocationModel.fromJson(response.data);
        } on DioException catch (error) {
          throw ServerException(message: error.response?.data['message']);
        }
      } catch (e) {
        throw ServerException(message: e.toString());
      }
    } else {
      throw const ServerException(message: 'Location services are disabled.');
    }
  }
}
