// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineStatusAdapter extends TypeAdapter<RoutineStatus> {
  @override
  final int typeId = 1;

  @override
  RoutineStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RoutineStatus.open;
      case 1:
        return RoutineStatus.active;
      case 2:
        return RoutineStatus.finished;
      case 3:
        return RoutineStatus.aborted;
      default:
        return RoutineStatus.open;
    }
  }

  @override
  void write(BinaryWriter writer, RoutineStatus obj) {
    switch (obj) {
      case RoutineStatus.open:
        writer.writeByte(0);
        break;
      case RoutineStatus.active:
        writer.writeByte(1);
        break;
      case RoutineStatus.finished:
        writer.writeByte(2);
        break;
      case RoutineStatus.aborted:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
