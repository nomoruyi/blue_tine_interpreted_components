part of 'routine_cubit.dart';

@immutable
sealed class RoutineState {}

final class RoutineInitial extends RoutineState {}

final class SavingRoutine extends RoutineState {}

final class RoutineSaved extends RoutineState {}
