// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin.enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PluginEnumAdapter extends TypeAdapter<PluginEnum> {
  @override
  final int typeId = 0;

  @override
  PluginEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PluginEnum.getUp;
      default:
        return PluginEnum.getUp;
    }
  }

  @override
  void write(BinaryWriter writer, PluginEnum obj) {
    switch (obj) {
      case PluginEnum.getUp:
        writer.writeByte(0);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PluginEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
