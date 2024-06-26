import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/pages/grocery_page.dart';
import 'package:recipe_and_meal_plan_app/pages/meal_plan_page.dart';
import 'package:recipe_and_meal_plan_app/pages/recipe_page.dart';
import 'package:recipe_and_meal_plan_app/pages/favorites_page.dart';
import 'package:recipe_and_meal_plan_app/favorites_manager.dart';

class DatesProvider extends ChangeNotifier {
  final List<DateTime> _dates = List<DateTime>.generate(
      7, (index) => DateTime.now().add(Duration(days: index)));

  List<DateTime> get dates => _dates;

  void loadMoreDates(int count) {
    final lastDate = _dates.last;
    List<DateTime> newDates = List<DateTime>.generate(
        count, (index) => lastDate.add(Duration(days: index + 1)));
    _dates.addAll(newDates);
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesManager(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const Dashboard(),
      ),
    ),
  );
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 1; // default landing page "Meals Plan"
  final List<Widget> pages = const [
    GroceryPage(),
    MealPlanPage(),
    RecipePage(),
    FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Groceries",
            icon: SizedBox(
              height: 40.0,
              child: Image.asset("icons/diet.png"),
            ),
          ),
          BottomNavigationBarItem(
            label: "Meal Plan",
            icon: SizedBox(
              height: 40.0,
              child: Image.asset("icons/nutrition.png"),
            ),
          ),
          BottomNavigationBarItem(
            label: "Recipes",
            icon: SizedBox(
              height: 40.0,
              child: Image.asset("icons/recipe.png"),
            ),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: SizedBox(
              height: 40.0,
              child: Image.asset("icons/favorite.png"),
            ),
          ),
        ],
      ),
    );
  }
}
