import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class RoutineDataSource extends CalendarDataSource {
  RoutineDataSource(List<Appointment> events) {
    appointments = events;
  }

  Appointment getEvent(int index) => appointments![index] as Appointment;

  @override
  String getSubject(int index) => getEvent(index).subject;

  @override
  DateTime getStartTime(int index) => getEvent(index).startTime;

  @override
  DateTime getEndTime(int index) => getEvent(index).endTime;

  @override
  String? getNotes(int index) => getEvent(index).notes;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;

  @override
  Color getColor(int index) => getEvent(index).color;

  @override
  String? getRecurrenceRule(int index) => getEvent(index).recurrenceRule;

  @override
  List<DateTime>? getRecurrenceExceptionDates(int index) => getEvent(index).recurrenceExceptionDates;
}
