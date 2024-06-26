import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/favorites_manager.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorites'),
      ),
      body: Consumer<FavoritesManager>(
        builder: (context, favoritesManager, child) {
          final favorites = favoritesManager.favorites;

          if (favorites.isEmpty) {
            return const Center(child: Text("No favorites yet."));
          }

          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            children: favorites
                .map((recipe) =>
                    buildGridItem(recipe, context, favoritesManager))
                .toList(),
          );
        },
      ),
    );
  }

  Widget buildGridItem(
      Recipe recipe, BuildContext context, FavoritesManager favoritesManager) {
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
              child: IconButton(
                icon: Icon(
                  favoritesManager.isFavorite(recipe)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.yellow[600],
                ),
                onPressed: () {
                  if (favoritesManager.isFavorite(recipe)) {
                    favoritesManager.removeFavorite(recipe);
                  } else {
                    favoritesManager.addFavorite(recipe);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
