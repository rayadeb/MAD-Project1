import 'package:isar/isar.dart';

part 'recipe.g.dart';

@Collection()
class Recipe {
  Id? id = Isar.autoIncrement;
  // String? author;
  int? cookTimeMinutes;
  String? description;
  // bool? error;
  // List<String>? footnotes;
  List<String>? ingredients;
  List<String>? instructions;
  String? photoUrl;
  int? prepTimeMinutes;
  double? ratingStars;
  // int? reviewCount;
  // int? timeScraped;
  String? title;
  String? totalTimeMinutes;
  // String? url;
  int? calories;
  String? fat;
  String? carbs;
  String? protein;
  bool favorited = false;

  Recipe(
      { this.id,
        // this.author,
        this.cookTimeMinutes,
        this.description,
        // this.error,
        // this.footnotes,
        this.ingredients,
        this.instructions,
        this.photoUrl,
        this.prepTimeMinutes,
        this.ratingStars,
        // this.reviewCount,
        // this.timeScraped,
        this.title,
        this.totalTimeMinutes,
        // this.url,
        this.calories,
        this.fat,
        this.carbs,
        this.protein,
        this.favorited = false});

  Recipe.fromJson(Map<String, dynamic> json) {
    // recipeId = json['recipe_id'];
    // author = json['author'];
    cookTimeMinutes = json['cook_time_minutes'];
    description = json['description'];
    // error = json['error'];
    // footnotes = json['footnotes'].cast<String>();
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'].cast<String>();
    photoUrl = json['photo_url'];
    prepTimeMinutes = json['prep_time_minutes'];
    ratingStars = json['rating_stars'].toDouble();
    // reviewCount = json['review_count'];
    // timeScraped = json['time_scraped'];
    title = json['title'];
    totalTimeMinutes = json['total_time_minutes'];
    // url = json['url'];
    calories = json['calories'];
    fat = json['fat'];
    carbs = json['carbs'];
    protein = json['protein'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['author'] = author;
    data['cook_time_minutes'] = cookTimeMinutes;
    data['description'] = description;
    // data['error'] = error;
    // data['footnotes'] = footnotes;
    data['ingredients'] = ingredients;
    data['instructions'] = instructions;
    data['photo_url'] = photoUrl;
    data['prep_time_minutes'] = prepTimeMinutes;
    data['rating_stars'] = ratingStars;
    // data['review_count'] = reviewCount;
    // data['time_scraped'] = timeScraped;
    data['title'] = title;
    data['total_time_minutes'] = totalTimeMinutes;
    // data['url'] = url;
    data['calories'] = calories;
    data['fat'] = fat;
    data['carbs'] = carbs;
    data['protein'] = protein;
    return data;
  }
}
