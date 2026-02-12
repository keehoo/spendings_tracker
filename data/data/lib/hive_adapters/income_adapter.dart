import 'package:data/data.dart';
import 'package:data/models/income_category_entity.dart';
import 'package:data/models/income_entity.dart';

class IncomeEntityAdapter extends TypeAdapter<IncomeEntity> {
  @override
  final int typeId = 12; // Unique, different from enum

  @override
  IncomeEntity read(BinaryReader reader) {
    return IncomeEntity(
      amount: reader.readString(),
      category: reader.read() as IncomeCategoryEntity,
      date: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      description: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, IncomeEntity obj) {
    writer.writeString(obj.amount);
    writer.write(obj.category);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.description);
  }
}
