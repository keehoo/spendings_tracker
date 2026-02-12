import 'package:data/models/transaction_category_entity.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionCategoryEntityAdapter
    extends TypeAdapter<TransactionCategoryEntity> {
  @override
  final int typeId = 10;

  @override
  TransactionCategoryEntity read(BinaryReader reader) {
    final index = reader.readByte();
    return TransactionCategoryEntity.values[index];
  }

  @override
  void write(BinaryWriter writer, TransactionCategoryEntity obj) {
    writer.writeByte(obj.index);
  }
}
