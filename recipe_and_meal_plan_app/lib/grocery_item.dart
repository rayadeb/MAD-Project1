import 'package:isar/isar.dart';

part 'grocery_item.g.dart';

@Collection()
class GroceryItem {
  Id? id = Isar.autoIncrement;
  String? item;
  bool checked;

  GroceryItem({
    this.id,
    this.item,
    this.checked = false,
  });
}