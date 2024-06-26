import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_detail_page.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class FavoritePage extends StatefulWidget {
  final Isar isar;
  const FavoritePage({super.key, required this.isar});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String _searchQuery = "";

  Future<List<Recipe>> getRecipes(String query) async {
    // await Future.delayed(const Duration(seconds: 1));
    // final queryBuilder = widget.isar.recipes.filter().titleContains(query.toLowerCase());

    if (query.isNotEmpty) {
      return await widget.isar.recipes
        .where()
        .filter()
        .titleContains(query, caseSensitive: false)
        .favoritedEqualTo(true)
        .findAll();
    } else {
      return await widget.isar.recipes
        .where()
        .filter()
        .favoritedEqualTo(true)
        .findAll();
    }
  }

  Future<void> addToFavorites(Recipe recipe) async {

    await widget.isar.writeTxn(() async {
      recipe.favorited = !recipe.favorited;
      await widget.isar.recipes.put(recipe);
      setState(() {
        
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorites", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xFF4D4D4D))),
        backgroundColor: const Color(0xFFDDEFDD),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search recipes...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ), 
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: getRecipes(_searchQuery),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  children: recipes.map((recipe) => buildGridItem(recipe)).toList(),
                  );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridItem(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipe: recipe)
          )
        );
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
              right: 10.0,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  recipe.title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      )
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: GestureDetector(
                onTap: () => addToFavorites(recipe),
                child: recipe.favorited ?
                  Icon(Icons.bookmark, color: Colors.yellow[600], size: 36.0) :
                  Icon(Icons.bookmark_border_rounded, color: Colors.yellow[600], size: 36.0,),
              )
              // child: Icon(Icons.bookmark_border_rounded, color: Colors.yellow[600], size: 36.0,),
            )
          ],
        ),
      ),
    );
  }
}