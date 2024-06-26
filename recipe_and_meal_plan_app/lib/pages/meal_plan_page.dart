import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/main.dart';
import 'package:recipe_and_meal_plan_app/meal_plan.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_page.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class MealPlanPage extends StatefulWidget {
  final Isar isar;
  const MealPlanPage({super.key, required this.isar});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  // final DatesProvider _datesProvider = DatesProvider();
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;
  MealPlan? mealPlan;
  Recipe? breakfast;
  Recipe? lunch;
  Recipe? dinner;

  Future<Recipe?> getRecipeById(int id) async {
    final recipe = await widget.isar.recipes.where().idEqualTo(id).findFirst();
    return recipe;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _selectedDate = DateTime.now();
    fetchData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Meal Plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color.fromARGB(255, 86, 77, 74))),
        backgroundColor: const Color.fromARGB(255, 239, 244, 250),
      ),
      body: Column(
        children: [
          buildWeekView(),
          buildTiles(),
        ],
      ),
      floatingActionButton: PopupMenuButton<int>(
        onSelected: (item) => onFabMenuItemSelected(item),
        icon: const Icon(Icons.add),
        itemBuilder: (context) => [
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => RecipePage(isar: widget.isar),
      //       )
      //     );
      //   },
      //   backgroundColor: const Color.fromARGB(255, 188, 227, 187),
      //   foregroundColor: const Color(0xFF4D4D4D),
      //   child: const Icon(Icons.add),
      // ),
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

    print(didChangeMealPlan);
    if (didChangeMealPlan) {
      fetchData();
    }
  }

  Widget buildCapsuleView(DateTime date) {
    final day = DateFormat("ccccc").format(date);
    final formattedDate = DateFormat("d").format(date);
    // final today = DateTime.now();
    // final isToday = date.year == today.year && date.month == today.month && date.day == today.day;
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
      fontSize: 24.0,
      // fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      color: isSelected ? Colors.white : const Color.fromARGB(255, 86, 77, 74)
    );

    TextStyle dateStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      color: isSelected ? Colors.white : const Color.fromARGB(255, 86, 77, 74)
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
      child: GestureDetector(
        onTap: () => _onDateSelected(date),
        child: Container(
          height: 100.0,
          width: capsuleWidth.floorToDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: capsuleColor,
            // gradient: const LinearGradient(
            //   colors: [Color.fromARGB(255, 143, 199, 142), Colors.transparent],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(day, style: textStyle),
                Text(formattedDate, style: dateStyle),
              ],
            ),
          )
        ),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    fetchData();
  }

  Widget buildWeekView() {
    return Consumer<DatesProvider>(
      builder: (context, datesProvider, child) {
        final dates = datesProvider.dates;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                return buildCapsuleView(date);
              },
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
            ),
          ),
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
          ListTile(
            title: Text("BREAKFAST", style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold)),
            subtitle: Text(
              breakfast?.title ?? "No meals planned yet",
              style: const TextStyle(fontSize: 30.0),),
            trailing: const Column(
              children: [
                Icon(Icons.fireplace_rounded),
                Text("600 Cal")
              ],
            ),
          ),
          ListTile(
            title: Text("LUNCH", style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold)),
            subtitle: Text(
              lunch?.title ?? "No meals planned yet",
              style: const TextStyle(fontSize: 30.0),),
            trailing: const Column(
              children: [
                Icon(Icons.fireplace_rounded),
                Text("600 Cal")
              ],
            ),
          ),
          ListTile(
            title: Text("DINNER", style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold)),
            subtitle: Text(
              dinner?.title ?? "No meals planned yet",
              style: const TextStyle(fontSize: 30.0),),
            trailing: const Column(
              children: [
                Icon(Icons.fireplace_rounded),
                Text("600 Cal")
              ],
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

  Future<void> fetchData() async {
    final DateTime selectedDateWithoutTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
    );

    final fetchedPlan = await widget.isar.mealPlans
      .where()
      .filter()
      .dateEqualTo(selectedDateWithoutTime)
      .findFirst();
    
    Recipe? breakfastRecipe;
    Recipe? lunchRecipe;
    Recipe? dinnerRecipe;

    if (fetchedPlan != null) {
      if (fetchedPlan.breakfastId != null) {
        breakfastRecipe = await widget.isar.recipes.get(fetchedPlan.breakfastId!);
      }
      if (fetchedPlan.lunchId != null) {
        lunchRecipe = await widget.isar.recipes.get(fetchedPlan.lunchId!);
      }
      if (fetchedPlan.dinnerId != null) {
        dinnerRecipe = await widget.isar.recipes.get(fetchedPlan.dinnerId!);
      }
    }
    
    setState(() {
      mealPlan = fetchedPlan;
      breakfast = breakfastRecipe;
      lunch = lunchRecipe;
      dinner = dinnerRecipe;
    });
  }
}