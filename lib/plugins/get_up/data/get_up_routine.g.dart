// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_up_routine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetUpRoutineAdapter extends TypeAdapter<GetUpRoutine> {
  @override
  final int typeId = 22;

  @override
  GetUpRoutine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetUpRoutine(
      fields[0] == null ? 'Routine Name' : fields[0] as String,
      fields[1] == null ? 'Routine Description' : fields[1] as String?,
      steps: fields[5] == null
          ? []
          : (fields[5] as List).cast<IPluginRoutineStep>(),
      startTime: fields[2] == null
          ? const TimeOfDay(hour: 6, minute: 0)
          : fields[2] as TimeOfDay,
      reminder: fields[4] == null ? false : fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GetUpRoutine obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.weekDays)
      ..writeByte(4)
      ..write(obj.reminder)
      ..writeByte(5)
      ..write(obj.steps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUpRoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
