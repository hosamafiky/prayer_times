import 'package:json_serializable_learn/core/extension/string.dart';
import 'package:json_serializable_learn/features/prayer_times/domain/entities/prayer.dart';

class DayPrayersModel extends DayPrayers {
  const DayPrayersModel({required super.timings, required super.date});

  factory DayPrayersModel.fromJson(Map<String, dynamic> json) {
    return DayPrayersModel(
      timings: TimingsModel.fromJson(json['timings']),
      date: DateModel.fromJson(json['date']),
    );
  }
}

class TimingsModel extends Timings {
  const TimingsModel({
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.maghrib,
    required super.isha,
  });

  factory TimingsModel.fromJson(Map<String, dynamic> json) {
    return TimingsModel(
      fajr: PrayerModel.fromJson({"arTitle": 'الفجر', 'title': 'Fajr', 'time': (json['Fajr'] as String).fromApi.toString()}),
      sunrise: PrayerModel.fromJson({"arTitle": 'الشروق', 'title': 'Sunrise', 'time': (json['Sunrise'] as String).fromApi.toString()}),
      dhuhr: PrayerModel.fromJson({"arTitle": 'الظهر', 'title': 'Dhuhur', 'time': (json['Dhuhr'] as String).fromApi.toString()}),
      asr: PrayerModel.fromJson({"arTitle": 'العصر', 'title': 'Asr', 'time': (json['Asr'] as String).fromApi.toString()}),
      maghrib: PrayerModel.fromJson({"arTitle": 'المغرب', 'title': 'Maghrib', 'time': (json['Maghrib'] as String).fromApi.toString()}),
      isha: PrayerModel.fromJson({"arTitle": 'العشاء', 'title': 'Isha', 'time': (json['Isha'] as String).fromApi.toString()}),
    );
  }
}

class PrayerModel extends Prayer {
  const PrayerModel({required super.arTitle, required super.title, required super.time});

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    return PrayerModel(arTitle: json['arTitle'], title: json['title'], time: DateTime.parse(json['time']));
  }
}

class DateModel extends Date {
  const DateModel({
    required super.readable,
    required super.timestamp,
    required super.gregorian,
    required super.hijri,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      readable: json['readable'],
      timestamp: json['timestamp'],
      gregorian: GregorianModel.fromJson(json['gregorian']),
      hijri: HijriModel.fromJson(json['hijri']),
    );
  }
}

class HijriModel extends Hijri {
  const HijriModel({
    required super.date,
    required super.format,
    required super.day,
    required super.weekday,
    required super.month,
    required super.year,
    required super.designation,
    required super.holidays,
  });

  factory HijriModel.fromJson(Map<String, dynamic> json) {
    return HijriModel(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: WeekdayModel.fromJson(json['weekday']),
      month: MonthModel.fromJson(json['month']),
      year: json['year'],
      designation: DesignationModel.fromJson(json['designation']),
      holidays: List<String>.from(json['holidays']),
    );
  }
}

class GregorianModel extends Gregorian {
  const GregorianModel({
    required super.date,
    required super.format,
    required super.day,
    required super.weekday,
    required super.month,
    required super.year,
    required super.designation,
  });

  factory GregorianModel.fromJson(Map<String, dynamic> json) {
    return GregorianModel(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: WeekdayModel.fromJson(json['weekday'], fromGregorianModel: true),
      month: MonthModel.fromJson(json['month'], fromGregorianModel: true),
      year: json['year'],
      designation: DesignationModel.fromJson(json['designation']),
    );
  }
}

class DesignationModel extends Designation {
  const DesignationModel({required super.abbreviated, required super.expanded});

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return DesignationModel(abbreviated: json['abbreviated'], expanded: json['expanded']);
  }
}

class WeekdayModel extends Weekday {
  const WeekdayModel({required super.en, required super.ar});

  factory WeekdayModel.fromJson(Map<String, dynamic> json, {bool fromGregorianModel = false}) {
    return WeekdayModel(en: json['en'], ar: fromGregorianModel ? '' : json['ar']);
  }
}

class MonthModel extends Month {
  const MonthModel({required super.number, required super.en, required super.ar});

  factory MonthModel.fromJson(Map<String, dynamic> json, {bool fromGregorianModel = false}) {
    return MonthModel(number: json['number'], en: json['en'], ar: fromGregorianModel ? '' : json['ar']);
  }
}
