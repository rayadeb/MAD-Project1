import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/database_helper.dart';
import 'package:recipe_and_meal_plan_app/main.dart';
import 'package:recipe_and_meal_plan_app/meal_plan.dart';
import 'package:recipe_and_meal_plan_app/meal_plan_data.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_detail_page.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_page.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class MealPlanPage extends StatefulWidget {
  final Isar isar;
  const MealPlanPage({super.key, required this.isar});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  late DatabaseHelper databaseHelper;
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;
  MealPlan? mealPlan;
  Recipe? breakfast;
  Recipe? lunch;
  Recipe? dinner;

  @override
  void initState() {
    super.initState();
    databaseHelper = Provider.of<DatabaseHelper>(context, listen: false);
    _scrollController.addListener(_onScroll);
    _selectedDate = DateTime.now();
    _fetchedMealPlan();
    // fetchData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchedMealPlan() async {
    final MealPlanData fetchedPlan = await databaseHelper.getMealPlans(_selectedDate!);
    setState(() {
      mealPlan = fetchedPlan.fetchedPlan;
      breakfast = fetchedPlan.breakfastRecipe;
      lunch = fetchedPlan.lunchRecipe;
      dinner = fetchedPlan.dinnerRecipe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Meal Plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xFF4D4D4D))),
        backgroundColor: const Color(0xFFDDEFDD),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      body: Column(
        children: [
          buildWeekView(),
          buildTiles(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMenu<int>(
            context: context,
            position: const RelativeRect.fromLTRB(110, 570, 110, 100),
            items: [
              const PopupMenuItem(
                value: 1,
                child: Text("Add to breakfast"),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text("Add to lunch"),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text("Add to dinner"),
              ),
            ],
            elevation: 20.0,
            color: const Color.fromARGB(255, 239, 244, 250),
          ).then((value) {
            if (value != null) {
              onFabMenuItemSelected(value);
            }
          });
        },
        backgroundColor: const Color.fromARGB(255, 188, 227, 187),
        foregroundColor: const Color(0xFF4D4D4D),
        child: const Icon(Icons.add),
      ),
    );
  }

  void onFabMenuItemSelected(item) async {
    // print(item);
    final didChangeMealPlan = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipePage(isar: widget.isar, fromMealPlanPage: true, selectedDate: _selectedDate, value: item,)
      )
    );

    if (didChangeMealPlan) {
      _fetchedMealPlan();
    }
  }

  Widget buildCapsuleView(DateTime date) {
    final day = DateFormat("ccccc").format(date);
    final formattedDate = DateFormat("d").format(date);
    final isSelected = _selectedDate != null && date.year == _selectedDate!.year && date.month == _selectedDate!.month && date.day == _selectedDate!.day;

    final double availableWidth = MediaQuery.of(context).size.width - 32.0;
    final double capsuleWidth = availableWidth / 7.0;

    Color capsuleColor;
    if (isSelected) {
      capsuleColor = const Color.fromARGB(255, 143, 199, 142);
    } else {
      capsuleColor = Colors.transparent;
    }

    TextStyle textStyle = TextStyle(
      fontSize: 22.0,
      // fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      color: isSelected ? Colors.white : const Color.fromARGB(255, 86, 77, 74)
    );

    TextStyle dateStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      color: isSelected ? Colors.white : const Color.fromARGB(255, 86, 77, 74)
    );

      
    return GestureDetector(
      onTap: () => _onDateSelected(date),
      child: Container(
        // height: 60.0,
        width: capsuleWidth.floorToDouble(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: capsuleColor,
          // gradient: const LinearGradient(
          //   colors: [Color.fromARGB(255, 143, 199, 142), Colors.transparent],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(day, style: textStyle),
            Text(formattedDate, style: dateStyle),
          ],
        ),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _fetchedMealPlan();
  }

  Widget buildWeekView() {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Consumer<DatesProvider>(
      builder: (context, datesProvider, child) {
        final dates = datesProvider.dates;

        return SizedBox(
          height: 160.0,
          width: availableWidth,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              return buildCapsuleView(date);
            },
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
          )
        );
      }
    );
  }

  Widget buildTiles() {

    // String breakfastText = breakfast?.title ?? "No meals planned yet";
    // String lunchText = lunch?.title ?? "No meals planned yet";
    // String dinnerText = dinner?.title ?? "No meals planned yet";

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (breakfast != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail(isar: databaseHelper.isar, recipe: breakfast!)
                  )
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(255, 239, 244, 250),
                ),
                child: ListTile(
                  title: Text("BREAKFAST", style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    breakfast?.title ?? "No meals planned yet",
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  trailing: Column(
                    children: [
                      SizedBox(
                        width: 40.0,
                        child: Image.asset(
                          "icons/calories.png",
                          color: const Color.fromARGB(255, 143, 199, 142),
                          colorBlendMode: BlendMode.srcIn,
                          ),
                      ),
                      Text(breakfast?.calories != null ? "${breakfast?.calories} cal" : "No calories"),
                      // Text(breakfast?.calories?.toString() ?? "No Calories")
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (lunch != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail(isar: databaseHelper.isar, recipe: lunch!)
                  )
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(255, 239, 244, 250),
                ),
                child: ListTile(
                  title: Text("LUNCH", style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    lunch?.title ?? "No meals planned yet",
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  trailing: Column(
                    children: [
                      SizedBox(
                        width: 40.0,
                        child: Image.asset(
                          "icons/calories.png",
                          color: const Color.fromARGB(255, 143, 199, 142),
                          colorBlendMode: BlendMode.srcIn,
                          ),
                      ),
                      Text(lunch?.calories != null ? "${lunch?.calories} cal" : "No calories"),
                      // Text(lunch?.calories?.toString() ?? "No Calories")
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (dinner != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail(isar: databaseHelper.isar, recipe: dinner!)
                  )
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(255, 239, 244, 250),
                ),
                child: ListTile(
                  title: Text("DINNER", style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    dinner?.title ?? "No meals planned yet",
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  trailing: Column(
                    children: [
                      SizedBox(
                        width: 40.0,
                        child: Image.asset(
                          "icons/calories.png",
                          color: const Color.fromARGB(255, 143, 199, 142),
                          colorBlendMode: BlendMode.srcIn,
                          ),
                      ),
                      Text(dinner?.calories != null ? "${dinner?.calories} cal" : "No calories"),
                      // Text(dinner?.calories?.toString() ?? "No Calories")
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      final datesProvider = Provider.of<DatesProvider>(context, listen: false);
      datesProvider.loadMoreDates(10);
    }
  }
}