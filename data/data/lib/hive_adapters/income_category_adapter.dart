
import 'package:data/data.dart';
import 'package:data/models/income_category_entity.dart';

class IncomeCategoryEntityAdapter extends TypeAdapter<IncomeCategoryEntity> {
  @override
  final int typeId = 13; // Unique across your app

  @override
  IncomeCategoryEntity read(BinaryReader reader) {
    final index = reader.readByte();
    return IncomeCategoryEntity.values[index];
  }

  @override
  void write(BinaryWriter writer, IncomeCategoryEntity obj) {
    writer.writeByte(obj.index);
  }
}