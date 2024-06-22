import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

const String RECIPE_DATA = 'assets/recipe_data.json';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  Future<List<Recipe>> getRecipes() async {
    String data = await DefaultAssetBundle.of(context).loadString(RECIPE_DATA);
    List<dynamic> mapData = jsonDecode(data);

    // print(mapData);
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
        // builder: (context, data) {
        //   if (data.hasData) {
        //     List<Recipe> recipes = data.data!;
        //     return ListView.builder(
        //       itemCount: recipes.length,
        //       itemBuilder: (context, index) {
        //         return ListTile(
        //           title: Text(recipes[index].name!),
        //         );
        //       });
        //   } else {
        //     return const CircularProgressIndicator();
        //   }
        // },
      ),
    );
  }

  Widget buildGridItem(Recipe recipe) {
    return Card(
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
    );
  }
}