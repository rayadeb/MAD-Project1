import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/database_helper.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_detail_page.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class FavoritePage extends StatefulWidget {
  final Isar isar;
  const FavoritePage({super.key, required this.isar});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late DatabaseHelper databaseHelper;
  String _searchQuery = "";
  
  @override
  void initState() {
    super.initState();
    databaseHelper = Provider.of<DatabaseHelper>(context, listen: false);
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
              future: databaseHelper.getFavoriteRecipes(_searchQuery),
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
            builder: (context) => RecipeDetail(isar: widget.isar, recipe: recipe)
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
                onTap: () async {
                  databaseHelper.addToFavorites(recipe);
                  setState(() {
                    
                  });
                },
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