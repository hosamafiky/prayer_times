import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.latitude,
    required super.longitude,
    required super.city,
    required super.countryName,
    required super.postCode,
    required super.locality,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        city: json['city'],
        countryName: json['countryName'],
        postCode: json['postcode'],
        locality: json['locality'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}
