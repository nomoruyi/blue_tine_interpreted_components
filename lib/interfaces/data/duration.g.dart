import 'package:hive_flutter/hive_flutter.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final typeId = 001; // Put an ID you didn't use yet.

  @override
  Duration read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Duration(
        milliseconds: fields[0] == null ? 0 : fields[0] as int,
    );
  }


  @override
  void write(BinaryWriter writer, Duration obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.inMilliseconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Duration &&
              runtimeType == other.runtimeType &&
              typeId == 1;

}
