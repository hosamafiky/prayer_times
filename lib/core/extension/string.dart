extension StringX on String {
  DateTime get toDateTime {
    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final day = DateTime.now().day;
    final hour = int.parse(split(':')[0]);
    final minute = int.parse(split(':')[1]);

    return DateTime(year, month, day, hour, minute);
  }

  DateTime get fromApi {
    RegExp pattern = RegExp(r'[0-9]{2}:[0-9]{2}');
    return pattern.firstMatch(this)!.group(0)!.toDateTime;
  }
}
