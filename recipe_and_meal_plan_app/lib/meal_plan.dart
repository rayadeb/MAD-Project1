import 'package:isar/isar.dart';

part 'meal_plan.g.dart';

@Collection()
class MealPlan {
  Id? id = Isar.autoIncrement;
  DateTime? date;
  int? breakfastId;
  int? lunchId;
  int? dinnerId;

  MealPlan({
    this.id,
    this.date,
    this.breakfastId,
    this.lunchId,
    this.dinnerId
  });
}