// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String city;
  final String countryName;
  final String postCode;
  final String locality;
  final double latitude;
  final double longitude;

  const Location({
    required this.locality,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.countryName,
    required this.postCode,
  });

  Map<String, dynamic> toMap() => {
        'city': city,
        'countryName': countryName,
        'postCode': postCode,
        'locality': locality,
        'latitude': latitude,
        'longitude': longitude,
      };

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [city, countryName, postCode, locality, latitude, longitude];
}
