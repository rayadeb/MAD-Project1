import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/database_helper.dart';
import 'package:recipe_and_meal_plan_app/grocery_item.dart';
import 'package:recipe_and_meal_plan_app/meal_plan.dart';
import 'package:recipe_and_meal_plan_app/pages/grocery_page.dart';
import 'package:recipe_and_meal_plan_app/pages/meal_plan_page.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_page.dart';
import 'package:recipe_and_meal_plan_app/pages/favorites_page.dart';
import 'package:isar/isar.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';
import 'package:path_provider/path_provider.dart';

class DatesProvider extends ChangeNotifier {
  final List<DateTime> _dates = List<DateTime>.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  List<DateTime> get dates => _dates;

  void loadMoreDates(int count) {
    final lastDate = _dates.last;
    final offset = _dates.length;
    List<DateTime> newDates = List<DateTime>.generate(count, (index) => lastDate.add(Duration(days: index + offset)));
    _dates.addAll(newDates);
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Isar instance
  final dir = await getApplicationCacheDirectory();
  final isar = await Isar.open([RecipeSchema, MealPlanSchema, GroceryItemSchema], directory: dir.path);

  // Initialize DatabaseHelper
  final databaseHelper = DatabaseHelper(isar);
  // databaseHelper.wipeDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatesProvider(),
        ),
        Provider<DatabaseHelper>.value(value: databaseHelper),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: child!,
          );
        },
        home: Dashboard(isar: isar),
      ),
    )
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class Dashboard extends StatefulWidget {
  final Isar isar;

  const Dashboard({super.key, required this.isar});

  // final DatesProvider datesProvider;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 1; // default landing page "Meals Plan"
  late List<Widget> pages;

  // final List<Widget> pages = const [
  //   GroceryPage(),
  //   MealPlanPage(),
  //   RecipePage(isar: isar),
  //   FavoritePage(),
  // ];

  @override
  void initState() {
    super.initState();
    pages = [
      GroceryPage(isar: widget.isar),
      MealPlanPage(isar: widget.isar),
      RecipePage(isar: widget.isar, fromMealPlanPage: false, selectedDate: null, value: null,),
      FavoritePage(isar: widget.isar),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 239, 149, 156),
        backgroundColor: const Color(0xFFDDEFDD),
        elevation: 5.0,
        selectedFontSize: 18.0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: 50.0,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Groceries",
            icon: SizedBox(
              height: 36.0,
              child: Image.asset(
                "icons/diet.png",
                color: _currentIndex == 0 ? const Color.fromARGB(255, 239, 149, 156) : const Color.fromARGB(255, 86, 77, 74),
                colorBlendMode: BlendMode.srcIn,
                fit: BoxFit.contain,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Meal Plan",
            icon: SizedBox(
              height: 36.0,
              child: Image.asset(
                "icons/nutrition.png",
                color: _currentIndex == 1 ? const Color.fromARGB(255, 239, 149, 156) : const Color.fromARGB(255, 86, 77, 74),
                colorBlendMode: BlendMode.srcIn,
              ),
            )
          ),
          BottomNavigationBarItem(
            label: "Recipes",
            icon: SizedBox(
              height: 36.0,
              child: Image.asset(
                "icons/recipe.png",
                color: _currentIndex == 2 ? const Color.fromARGB(255, 239, 149, 156) : const Color.fromARGB(255, 86, 77, 74),
                colorBlendMode: BlendMode.srcIn,
              )
            )
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: SizedBox(
              height: 36.0,
              child: Image.asset(
                "icons/favorite.png",
                color: _currentIndex == 3 ? const Color.fromARGB(255, 239, 149, 156) : const Color.fromARGB(255, 86, 77, 74),
                colorBlendMode: BlendMode.srcIn,
              )
            )
          ),
        ],
      ),
    );
  }
}