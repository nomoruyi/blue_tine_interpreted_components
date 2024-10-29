import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day && tomorrow.month == month && tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;

    return 0;
  }

  bool isBefore(TimeOfDay other) => compareTo(other) < 0;

  bool isAfter(TimeOfDay other) => compareTo(other) > 0;

  TimeOfDay add(Duration duration) {
    assert(duration.inMinutes + (hour * 60 + minute) < TimeOfDay.hoursPerDay * TimeOfDay.minutesPerHour);

    int hours = duration.inMinutes ~/ TimeOfDay.minutesPerHour;
    int minutes = duration.inMinutes % TimeOfDay.minutesPerHour;

    return TimeOfDay(hour: hour + hours, minute: minute + minutes);
  }

  Duration operator -(TimeOfDay other) => Duration(hours: hour - other.hour, minutes: minute - other.minute);
}

extension DurationExtension on Duration {
  String formatDuration() {
    int seconds = inSeconds;
    bool isNegative = seconds < 0;

    if (isNegative) {
      seconds = seconds.abs();
    }

    final int days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final int hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final int minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];

    if (hours != 0 || tokens.isNotEmpty) {
      tokens.add('${hours}h');
    }
    if (minutes != 0 || tokens.isNotEmpty) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    final String result = tokens.join(' ');

    return isNegative ? '-$result' : result;
  }
}
