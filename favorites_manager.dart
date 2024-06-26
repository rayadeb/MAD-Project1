import 'package:flutter/material.dart';
import 'package:recipe_and_meal_plan_app/recipe.dart';

class FavoritesManager with ChangeNotifier {
  List<Recipe> _favorites = [];

  List<Recipe> get favorites => _favorites;

  void addFavorite(Recipe recipe) {
    if (!_favorites.contains(recipe)) {
      _favorites.add(recipe);
      notifyListeners();
    }
  }

  void removeFavorite(Recipe recipe) {
    if (_favorites.contains(recipe)) {
      _favorites.remove(recipe);
      notifyListeners();
    }
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.contains(recipe);
  }
}
