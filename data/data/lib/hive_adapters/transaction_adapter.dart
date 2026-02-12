import 'package:data/models/transaction_category_entity.dart';
import 'package:data/models/transaction_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionEntityAdapter extends TypeAdapter<TransactionEntity> {
  @override
  final int typeId = 11; // must match @HiveType in TransactionEntity

  @override
  TransactionEntity read(BinaryReader reader) {
    final amount = reader.readString();
    final category = TransactionCategoryEntity.values[reader.readByte()];
    final date = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final description = reader.readString();

    return TransactionEntity(
      amount: amount,
      category: category,
      date: date,
      description: description,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionEntity obj) {
    writer.writeString(obj.amount);
    writer.writeByte(obj.category.index);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.description);
  }
}
