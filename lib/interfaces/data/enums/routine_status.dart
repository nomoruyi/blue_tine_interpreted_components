import 'package:hive_flutter/adapters.dart';

part 'routine_status.g.dart';

@HiveType(typeId: 001)
enum RoutineStatus {
  @HiveField(0)
  open,
  @HiveField(1)
  active,
  @HiveField(2)
  finished,
  @HiveField(3)
  aborted
}