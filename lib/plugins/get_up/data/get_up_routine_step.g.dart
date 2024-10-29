// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_up_routine_step.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetUpRoutineStepAdapter extends TypeAdapter<GetUpRoutineStep> {
  @override
  final int typeId = 23;

  @override
  GetUpRoutineStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetUpRoutineStep(
      fields[0] == null ? 'Step Name' : fields[0] as String,
      fields[1] == null ? 'Step Description' : fields[1] as String?,
      duration: fields[2] == null
          ? const Duration(minutes: 5)
          : fields[2] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, GetUpRoutineStep obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.autoNext);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUpRoutineStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
