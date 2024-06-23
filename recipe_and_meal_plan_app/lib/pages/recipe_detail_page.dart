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
          buildTabBar(),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return Expanded(
      child: TabBarView(
        controller: _controller,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: buildOverviewTab(),
          ),
          buildIngredientsTab(),
          buildDirectionTab(),
        ],
      )
    );
  }

  Widget buildOverviewTab() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.food_bank_rounded),
                  Text("Servings"),
                  Spacer(),
                  Text('4'),
                ],
              ),
              Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 86, 77, 74),
              ),
              Row(
                children: [
                  Icon(Icons.food_bank_rounded),
                  Text("Servings"),
                  Spacer(),
                  Text('4'),
                ],
              ),
              Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 86, 77, 74),
              ),
              Row(
                children: [
                  Icon(Icons.food_bank_rounded),
                  Text("Servings"),
                  Spacer(),
                  Text('4'),
                ],
              ),
              Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 86, 77, 74),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Protein", style: TextStyle(fontSize: 20.0),),
                    Text("28g", style: TextStyle(fontSize: 40.0, color: Color.fromARGB(255, 150, 171, 217)),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text("Carbs", style: TextStyle(fontSize: 20.0),),
                    Text("7g", style: TextStyle(fontSize: 40.0, color: Color.fromARGB(255, 150, 171, 217)),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text("Fat", style: TextStyle(fontSize: 20.0),),
                    Text("32g", style: TextStyle(fontSize: 40.0, color: Color.fromARGB(255, 150, 171, 217)),),
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }

  Widget buildIngredientsTab() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.recipe.ingredients!.length,
              itemBuilder: (context, index) => buildIngredientRow(widget.recipe.ingredients![index]),
            )
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const FittedBox(
                child: Row(
                  children: [
                    Icon(Icons.shopping_basket_rounded),
                    Text("Add all to grocery list"),
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIngredientRow(String colData) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.add_box_rounded),
            Flexible(
              child: Text(
                colData,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 0.5,
          color: Color.fromARGB(255, 86, 77, 74),
        )
      ],
    );
  }

  Widget buildDirectionTab() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.recipe.instructions!.length,
              itemBuilder: (context, index) => buildDirectionRow(index, widget.recipe.instructions![index]),
            )
          )
        ],
      )
    );
  }

  Widget buildDirectionRow(int index, String insData) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              (index + 1).toString(),
              style: const TextStyle(
                color: Color.fromARGB(255, 150, 171, 217),
                fontSize: 40.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(width: 20.0,),
            Flexible(
              child : Text(
                insData,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}