// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DayPrayers extends Equatable {
  final Timings timings;
  final Date date;

  const DayPrayers({
    required this.timings,
    required this.date,
  });

  Prayer? getNextPrayer() {
    final now = DateTime.now();
    if (timings.fajr.time.isAfter(now)) {
      return timings.fajr;
    } else if (timings.dhuhr.time.isAfter(now)) {
      return timings.dhuhr;
    } else if (timings.asr.time.isAfter(now)) {
      return timings.asr;
    } else if (timings.maghrib.time.isAfter(now)) {
      return timings.maghrib;
    } else if (timings.isha.time.isAfter(now)) {
      return timings.isha;
    } else {
      return null;
    }
  }

  @override
  List<Object> get props => [timings, date];
}

class Timings extends Equatable {
  final Prayer fajr;
  final Prayer sunrise;
  final Prayer dhuhr;
  final Prayer asr;
  final Prayer maghrib;
  final Prayer isha;

  const Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  @override
  List<Object> get props => [fajr, sunrise, dhuhr, asr, maghrib, isha];
}

class Prayer extends Equatable {
  final String arTitle;
  final String title;
  final DateTime time;

  const Prayer({
    required this.arTitle,
    required this.title,
    required this.time,
  });
  Prayer copyWith({
    String? arTitle,
    String? title,
    DateTime? time,
  }) {
    return Prayer(
      arTitle: arTitle ?? this.arTitle,
      title: title ?? this.title,
      time: time ?? this.time,
    );
  }

  @override
  List<Object> get props => [arTitle, title, time];
}

class Date extends Equatable {
  final String readable;
  final String timestamp;
  final Gregorian gregorian;
  final Hijri hijri;

  const Date({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });

  @override
  List<Object> get props => [readable, timestamp, gregorian, hijri];
}

class Gregorian extends Equatable {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;

  const Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  @override
  List<Object> get props => [date, format, day, weekday, month, year, designation];
}

class Hijri extends Equatable {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;
  final List<String> holidays;

  const Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });

  @override
  List<Object> get props => [date, format, day, weekday, month, year, designation, holidays];
}

class Designation extends Equatable {
  final String abbreviated;
  final String expanded;

  const Designation({
    required this.abbreviated,
    required this.expanded,
  });

  @override
  List<Object> get props => [abbreviated, expanded];
}

class Weekday extends Equatable {
  final String en;
  final String ar;

  const Weekday({
    required this.en,
    required this.ar,
  });

  @override
  List<Object> get props => [en, ar];
}

class Month extends Equatable {
  final int number;
  final String en;
  final String ar;

  const Month({
    required this.number,
    required this.en,
    required this.ar,
  });

  @override
  List<Object> get props => [number, en, ar];
}

class Params extends Equatable {
  final int fajr;
  final int isha;

  const Params({
    required this.fajr,
    required this.isha,
  });

  @override
  List<Object> get props => [fajr, isha];
}
