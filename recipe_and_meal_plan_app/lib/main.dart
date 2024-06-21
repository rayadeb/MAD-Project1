import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true
    ),
    home: const Dashboard(),
  ));
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.menu),
    Icon(Icons.person)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
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
            )
          ),
          BottomNavigationBarItem(
            label: "Recipes",
            icon: SizedBox(
              height: 40.0,
              child: Image.asset("icons/recipe.png")
            )
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: SizedBox(
              height: 40.0,
              child: Image.asset("icons/favorite.png")
            )
          ),
        ],
      ),
    );
  }
}