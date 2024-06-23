import 'package:flutter/material.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe ;

  const RecipeDetail({super.key, required this.recipe});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text(widget.recipe.title!),
        title: Text(widget.recipe.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color.fromARGB(255, 86, 77, 74))),
        backgroundColor: const Color.fromARGB(255, 239, 244, 250),
      ),
      body: Column(
        children: [
          Image.network(
            widget.recipe.photoUrl!,
            fit: BoxFit.cover,
            height: 200.0,
          ),
          TabBar(
            controller: _controller,
            tabs: const [
              Tab(text: "Overview",),
              Tab(text: "Ingredients",),
              Tab(text: "Directions",),
            ]
          ),
          buildTabBarAndContent(),
        ],
      ),
    );
  }

  Widget buildTabBarAndContent() {
    return Expanded(
      child: TabBarView(
        controller: _controller,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: buildOverviewTab(),
          ),
          const Text('data'),
          const Text('data'),
        ],
      )
    );
  }

  Widget buildOverviewTab() {
    return const Column(
      children: [
        Row(
          children: [
            Icon(Icons.food_bank),
            Text("Servings"),
            Spacer(),
            Text('4'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.food_bank),
            Text("Calories"),
            Spacer(),
            Text('600'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.food_bank),
            Text("Total Time"),
            Spacer(),
            Text('30m'),
          ],
        ),
      ],
    );
  }
}