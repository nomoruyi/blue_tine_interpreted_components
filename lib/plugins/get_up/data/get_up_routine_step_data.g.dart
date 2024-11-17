// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_up_routine_step_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetUpRoutineStepDataAdapter extends TypeAdapter<GetUpRoutineStepData> {
  @override
  final int typeId = 25;

  @override
  GetUpRoutineStepData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetUpRoutineStepData(
      fields[0] as IPluginRoutineStep,
      skipped: fields[5] == null ? false : fields[5] as bool,
    )
      ..status =
          fields[1] == null ? RoutineStatus.open : fields[1] as RoutineStatus
      ..startTime = fields[2] as DateTime
      ..endTime = fields[3] as DateTime
      ..duration = fields[4] as Duration;
  }

  @override
  void write(BinaryWriter writer, GetUpRoutineStepData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.step)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.skipped);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUpRoutineStepDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
