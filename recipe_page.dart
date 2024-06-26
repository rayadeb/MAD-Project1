import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_detail_page.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';
import 'package:recipe_and_meal_plan_app/favorites_manager.dart';

const String RECIPE_DATA = 'assets/formatted_recipe_data.json';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Future<List<Recipe>> getRecipes() async {
    String data = await DefaultAssetBundle.of(context).loadString(RECIPE_DATA);
    List<dynamic> mapData = jsonDecode(data);

    List<Recipe> recipes =
        mapData.map((recipe) => Recipe.fromJson(recipe)).toList();

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
        title: const Text(
          "Recipes",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Color.fromARGB(255, 86, 77, 74)),
        ),
        backgroundColor: const Color.fromARGB(255, 239, 244, 250),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
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
            children: recipes
                .map((recipe) => buildGridItem(recipe, context))
                .toList(),
          );
        },
      ),
    );
  }

  Widget buildGridItem(Recipe recipe, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetail(recipe: recipe)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
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
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: Consumer<FavoritesManager>(
                builder: (context, favoritesManager, child) {
                  final isFavorite = favoritesManager.isFavorite(recipe);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.yellow[600],
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        favoritesManager.removeFavorite(recipe);
                      } else {
                        favoritesManager.addFavorite(recipe);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
