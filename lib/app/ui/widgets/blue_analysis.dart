import 'package:blue_tine_interpreted_components/app/ui/widgets/blue_container.dart';
import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/app/data/calendar/i_plugin_routine_data_source.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/blue_card.dart';
import 'package:blue_tine_interpreted_components/utils/_utils.export.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Headline extends StatelessWidget {
  const Headline(this.routineCubit, {super.key});

  final PluginController routineCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Overview', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          ],
        ),
        BlueContainer(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${routineCubit.getCurrentStreak()}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                  const Text('Current streak'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${routineCubit.getMaxStreak()}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                  const Text('Max. streak'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${routineCubit.getTotalExecutions()}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                  const Text('Total Executions'),
                ],
              )
            ],
          ),
        ),
        BlueContainer(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(const TimeOfDay(hour: 17, minute: 32).format(context),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                  const Text('Avg. start time'),
                ],
              ),
              Column(
                children: [
                  Text('${4}m ${30}s', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                  const Text('Avg. time'),
                ],
              ),
            ],
          ),
        ),
        BlueContainer(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  RatingBar.builder(
                    initialRating: routineCubit.getAvgRating(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    wrapAlignment: WrapAlignment.center,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 48.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber.getShadeColor(),
                    ),
                    onRatingUpdate: (double rating) {},
                  ),
                  const Text('Avg. rating'),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class Calendar extends StatelessWidget {
  Calendar(this.routineCubit, {super.key, required this.calendarEntries});

  final PluginController routineCubit;
  final CalendarController _calendarController = CalendarController();
  final List<Appointment> calendarEntries;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('ENTRIES: $calendarEntries');
    }
    Size deviceSize = MediaQuery.of(context).size;

    return BlueCard(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Calendar', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
            Text('< Aug 2024 >', style: Theme.of(context).textTheme.bodyLarge)
          ],
        ),
        child: SizedBox(
          height: deviceSize.height * 0.5,
          child: SfCalendar(
            controller: _calendarController,
            dataSource: RoutineDataSource(calendarEntries),
            timeSlotViewSettings: const TimeSlotViewSettings(timeIntervalHeight: -1),
            initialSelectedDate: DateTime.now(),
            firstDayOfWeek: DateTime.monday,
            view: CalendarView.month,
            viewHeaderHeight: 32,
            headerHeight: 40,
            allowViewNavigation: false,
            appointmentTimeTextFormat: DateFormat.HOUR24_MINUTE,
            showNavigationArrow: true,
            showDatePickerButton: true,
            todayTextStyle: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
            onTap: (CalendarTapDetails detail) {
              if (detail.targetElement == CalendarElement.appointment) {
                if (kDebugMode) {
                  print(detail.appointments);
                }
              }
            },
            selectionDecoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            headerStyle: const CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            viewHeaderStyle: const ViewHeaderStyle(
                dayTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                dateTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            monthViewSettings: const MonthViewSettings(
              // agendaViewHeight: deviceSize.height * 0.15,

                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
                numberOfWeeksInView: 5,
                navigationDirection: MonthNavigationDirection.horizontal,
                showTrailingAndLeadingDates: false,
                agendaStyle: AgendaStyle(
                    appointmentTextStyle: TextStyle(fontSize: 14, color: Colors.black),
                    dateTextStyle: TextStyle(fontSize: 16, color: Colors.white),
                    dayTextStyle: TextStyle(fontSize: 14, color: Colors.white)),
                monthCellStyle: MonthCellStyle(
                    textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
                    leadingDatesTextStyle: TextStyle(fontSize: 18, color: Colors.white),
                    trailingDatesTextStyle: TextStyle(fontSize: 18, color: Colors.white))),
          ),
        ));
  }
}

class LastExecs extends StatelessWidget {
  const LastExecs(this.routineCubit, {super.key});

  final PluginController routineCubit;

  @override
  Widget build(BuildContext context) {
    return BlueCard(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('Last Executions', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: routineCubit.routines.take(100).map<Widget>((data) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            isThreeLine: true,
            title: Text(DateFormat.yMd('de').format(data.startTime)),
            subtitle: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RatingBar.builder(
                        initialRating: data.rating,
                        ignoreGestures: true,
                        minRating: 1,
                        direction: Axis.horizontal,
                        wrapAlignment: WrapAlignment.center,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 24.0,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber.getShadeColor(),
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            trailing: Text(
              data.duration.formatDuration(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
