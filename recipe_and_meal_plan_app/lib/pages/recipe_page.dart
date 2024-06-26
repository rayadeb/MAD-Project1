import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_and_meal_plan_app/meal_plan.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_detail_page.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

const String RECIPE_DATA = 'assets/formatted_recipe_data.json';

class RecipePage extends StatefulWidget {
  final Isar isar;
  final bool fromMealPlanPage;
  final DateTime? selectedDate;
  final int? value;
  const RecipePage({super.key, required this.isar, required this.fromMealPlanPage, required this.selectedDate, required this.value});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool _didChangeMealPlan = false;

  Future<void> addRecipesFromJson(Isar isar) async {
    // Parse
    String data = await DefaultAssetBundle.of(context).loadString(RECIPE_DATA);
    final List<dynamic> jsonData = jsonDecode(data);

    // Convert JSON data to Recipe objects
    final List<Recipe> recipes = jsonData.map((json) => Recipe.fromJson(json)).toList();

    // Add recipes to Isar database
    await isar.writeTxn(() async {
      await isar.recipes.putAll(recipes);
    });
  }

  Future<List<Recipe>> getRecipes() async {
    return await widget.isar.recipes.where().findAll();
  }

  // Future<List<Recipe>> getRecipes() async {
  //   String data = await DefaultAssetBundle.of(context).loadString(RECIPE_DATA);
  //   List<dynamic> mapData = jsonDecode(data);

  //   // print(mapData);
  //   List<Recipe> recipes = mapData.map((recipe) => Recipe.fromJson(recipe)).toList();

  //   return recipes;
  // }

  @override
  void initState() {
    super.initState();
    // Uncomment to init the database for the first time
    // addRecipesFromJson(widget.isar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Recipes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color.fromARGB(255, 86, 77, 74))),
        backgroundColor: const Color.fromARGB(255, 239, 244, 250),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Recipe> recipes = snapshot.data!;
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            children: recipes.map((recipe) => buildGridItem(recipe)).toList(),
            );
        }
      ),
    );
  }

  Widget buildGridItem(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        if (widget.fromMealPlanPage) {
          addToMealPlan(recipe);
          Future.delayed(const Duration(milliseconds: 100), () {
            Navigator.pop(context, _didChangeMealPlan);
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipe: recipe)
            )
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Image.network(
              recipe.photoUrl!,
              fit: BoxFit.cover,
              height: 200.0,
            ),
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: Text(
                recipe.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  
                )
              ),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: Icon(Icons.star, color: Colors.yellow[600]),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addToMealPlan(Recipe recipe) async {
    // final dir = await getApplicationCacheDirectory();
    // final isar = await Isar.open([MealPlanSchema], directory: dir.path);

    await widget.isar.writeTxn(() async {
      final DateTime selectedDateWithoutTime = DateTime(
        widget.selectedDate!.year,
        widget.selectedDate!.month,
        widget.selectedDate!.day,
      );

      final existingPlan = await widget.isar.mealPlans
        .where()
        .filter()
        .dateEqualTo(selectedDateWithoutTime)
        .findFirst();

      if (existingPlan != null) {
        switch (widget.value) {
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
        await widget.isar.mealPlans.put(existingPlan);
        print("Updated meal plan for $selectedDateWithoutTime");
      } else {
        await widget.isar.mealPlans.put(
          MealPlan(
            date: selectedDateWithoutTime,
            breakfastId: widget.value == 1 ? recipe.id : null,
            lunchId: widget.value == 2 ? recipe.id : null,
            dinnerId: widget.value == 3 ? recipe.id : null
          )
        );
        print("Added new meal plan for $selectedDateWithoutTime");
      }
      setState(() {
        _didChangeMealPlan = true;
        print("Setting _didChangeMealPlan to true");
      });
    });
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}