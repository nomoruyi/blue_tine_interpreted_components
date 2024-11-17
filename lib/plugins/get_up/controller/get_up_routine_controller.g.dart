// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_up_routine_controller.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetUpControllerAdapter extends TypeAdapter<GetUpController> {
  @override
  final int typeId = 20;

  @override
  GetUpController read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetUpController(
      fields[0] as PluginEnum,
    )..isInstalled = fields[1] == null ? false : fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, GetUpController obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.plugin)
      ..writeByte(1)
      ..write(obj.isInstalled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUpControllerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
