import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:recipe_and_meal_plan_app/grocery_item.dart';
import 'package:recipe_and_meal_plan_app/meal_plan.dart';
import 'package:recipe_and_meal_plan_app/meal_plan_data.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class DatabaseHelper{
  static const String RECIPE_DATA = "assets/formatted_recipe_data.json";
  final Isar isar;

  DatabaseHelper(this.isar) {
    addRecipesFromJson(isar);
  }

  // DatabaseHelper(this.isar);

  Future<void> addRecipesFromJson(Isar isar) async {
    // Check if the recipes collection is already populated
    final existingRecipes = await isar.recipes.count();
    if (existingRecipes > 0) {
      return;
    }
    // Parse
    String data = await rootBundle.loadString(RECIPE_DATA);
    // String data = await DefaultAssetBundle.of(context).loadString(RECIPE_DATA);
    final List<dynamic> jsonData = jsonDecode(data);

    // Convert JSON data to Recipe objects
    final List<Recipe> recipes = jsonData.map((json) => Recipe.fromJson(json)).toList();

    // Add recipes to Isar database
    await isar.writeTxn(() async {
      await isar.recipes.putAll(recipes);
    });
  }

  Future<List<Recipe>> getRecipes(String query) async {
    if (query.isNotEmpty) {
      return await isar.recipes
        .where()
        .filter()
        .titleContains(query, caseSensitive: false)
        .findAll();
    } else {
      return await isar.recipes.where().findAll();
    }
  }

  Future<List<Recipe>> getFavoriteRecipes(String query) async {
    if (query.isNotEmpty) {
      return await isar.recipes
        .where()
        .filter()
        .titleContains(query, caseSensitive: false)
        .favoritedEqualTo(true)
        .findAll();
    } else {
      return await isar.recipes
        .where()
        .filter()
        .favoritedEqualTo(true)
        .findAll();
    }
  }

  Future<void> addToFavorites(Recipe recipe) async {

    await isar.writeTxn(() async {
      recipe.favorited = !recipe.favorited;
      await isar.recipes.put(recipe);
    });
  }

  Future<void> addToMealPlan(Recipe recipe, DateTime selectedDate, int value) async {
    // final dir = await getApplicationCacheDirectory();
    // final isar = await Isar.open([MealPlanSchema], directory: dir.path);

    await isar.writeTxn(() async {
      final DateTime selectedDateWithoutTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );

      final existingPlan = await isar.mealPlans
        .where()
        .filter()
        .dateEqualTo(selectedDateWithoutTime)
        .findFirst();

      if (existingPlan != null) {
        switch (value) {
          case 1:
            existingPlan.breakfastId = recipe.id;
            break;
          case 2:
            existingPlan.lunchId = recipe.id;
            break;
          case 3:
            existingPlan.dinnerId = recipe.id;
            break;
        }
        await isar.mealPlans.put(existingPlan);
        print("Updated meal plan for $selectedDateWithoutTime");
      } else {
        await isar.mealPlans.put(
          MealPlan(
            date: selectedDateWithoutTime,
            breakfastId: value == 1 ? recipe.id : null,
            lunchId: value == 2 ? recipe.id : null,
            dinnerId: value == 3 ? recipe.id : null
          )
        );
        print("Added new meal plan for $selectedDateWithoutTime");
      }
    });
  }

  Future<MealPlanData> getMealPlans(DateTime selectedDate) async {
    final DateTime selectedDateWithoutTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final fetchedPlan = await isar.mealPlans
      .where()
      .filter()
      .dateEqualTo(selectedDateWithoutTime)
      .findFirst();
    
    Recipe? breakfastRecipe;
    Recipe? lunchRecipe;
    Recipe? dinnerRecipe;

    if (fetchedPlan != null) {
      if (fetchedPlan.breakfastId != null) {
        breakfastRecipe = await isar.recipes.get(fetchedPlan.breakfastId!);
      }
      if (fetchedPlan.lunchId != null) {
        lunchRecipe = await isar.recipes.get(fetchedPlan.lunchId!);
      }
      if (fetchedPlan.dinnerId != null) {
        dinnerRecipe = await isar.recipes.get(fetchedPlan.dinnerId!);
      }
    }

    return MealPlanData(
      fetchedPlan: fetchedPlan,
      breakfastRecipe: breakfastRecipe,
      lunchRecipe: lunchRecipe,
      dinnerRecipe: dinnerRecipe,
    );
  }

  void addItem(String itemName) async {
    if (itemName.isNotEmpty) {

      final newGrocery = GroceryItem(item: itemName);
      await isar.writeTxn(() async {
        await isar.groceryItems.put(newGrocery);
      });
    }
  }

  void addAllItems(List<String> itemNames) async {
    if (itemNames.isNotEmpty) {
      await isar.writeTxn(() async {
        for (final itemName in itemNames) {
          final newGrocery = GroceryItem(item: itemName);
          await isar.groceryItems.put(newGrocery);
        }
      });
    }
  }

  // Method to wipe the entire database
  Future<void> wipeDatabase() async {
    await isar.writeTxn(() async {
      await isar.recipes.where().deleteAll();
      await isar.groceryItems.where().deleteAll();
      await isar.mealPlans.where().deleteAll();
    });
  }
}