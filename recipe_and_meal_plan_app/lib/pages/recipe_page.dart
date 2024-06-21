import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  Future<List<Recipe>> getRecipes() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/recipes.json");
    List mapData = jsonDecode(data);

    print(mapData);
    List<Recipe> recipes = mapData.map((recipe) => Recipe.fromJson(recipe)).toList();

    return recipes;
  }

  @override
  void initState() {
    getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipes'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: getRecipes(),
        builder: (context, data) {
          if (data.hasData) {
            List<Recipe> recipes = data.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(recipes[index].name!),
                );
              });
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}