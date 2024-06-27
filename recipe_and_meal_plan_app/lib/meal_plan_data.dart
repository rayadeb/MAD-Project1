import 'package:recipe_and_meal_plan_app/meal_plan.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class MealPlanData {
  final MealPlan? fetchedPlan;
  final Recipe? breakfastRecipe;
  final Recipe? lunchRecipe;
  final Recipe? dinnerRecipe;

  MealPlanData({
    this.fetchedPlan,
    this.breakfastRecipe,
    this.lunchRecipe,
    this.dinnerRecipe,
  });
}