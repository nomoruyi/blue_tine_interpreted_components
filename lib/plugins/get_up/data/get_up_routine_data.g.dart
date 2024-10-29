// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_up_routine_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetUpRoutineDataAdapter extends TypeAdapter<GetUpRoutineData> {
  @override
  final int typeId = 22;

  @override
  GetUpRoutineData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetUpRoutineData(
      fields[0] as IPluginRoutine,
      status:
          fields[1] == null ? RoutineStatus.open : fields[1] as RoutineStatus,
      rating: fields[4] == null ? 0 : fields[4] as double,
    )
      ..startTime = fields[2] as DateTime
      ..endTime = fields[3] as DateTime
      ..comment = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, GetUpRoutineData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.routine)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.stepsData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUpRoutineDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
