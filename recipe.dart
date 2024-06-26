class Recipe {
  int? recipeId;
  String? author;
  int? cookTimeMinutes;
  String? description;
  bool? error;
  List<String>? footnotes;
  List<String>? ingredients;
  List<String>? instructions;
  String? photoUrl;
  int? prepTimeMinutes;
  double? ratingStars;
  int? reviewCount;
  int? timeScraped;
  String? title;
  int? totalTimeMinutes;
  String? url;
  int? calories;
  String? fat;
  String? carbs;
  String? protein;

  Recipe(
      { this.recipeId,
        this.author,
        this.cookTimeMinutes,
        this.description,
        this.error,
        this.footnotes,
        this.ingredients,
        this.instructions,
        this.photoUrl,
        this.prepTimeMinutes,
        this.ratingStars,
        this.reviewCount,
        this.timeScraped,
        this.title,
        this.totalTimeMinutes,
        this.url,
        this.calories,
        this.fat,
        this.carbs,
        this.protein});

  Recipe.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipe_id'];
    author = json['author'];
    cookTimeMinutes = json['cook_time_minutes'];
    description = json['description'];
    error = json['error'];
    footnotes = json['footnotes'].cast<String>();
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'].cast<String>();
    photoUrl = json['photo_url'];
    prepTimeMinutes = json['prep_time_minutes'];
    ratingStars = json['rating_stars'].toDouble();
    reviewCount = json['review_count'];
    timeScraped = json['time_scraped'];
    title = json['title'];
    totalTimeMinutes = json['total_time_minutes'];
    url = json['url'];
    calories = json['calories'];
    fat = json['fat'];
    carbs = json['carbs'];
    protein = json['protein'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['cook_time_minutes'] = this.cookTimeMinutes;
    data['description'] = this.description;
    data['error'] = this.error;
    data['footnotes'] = this.footnotes;
    data['ingredients'] = this.ingredients;
    data['instructions'] = this.instructions;
    data['photo_url'] = this.photoUrl;
    data['prep_time_minutes'] = this.prepTimeMinutes;
    data['rating_stars'] = this.ratingStars;
    data['review_count'] = this.reviewCount;
    data['time_scraped'] = this.timeScraped;
    data['title'] = this.title;
    data['total_time_minutes'] = this.totalTimeMinutes;
    data['url'] = this.url;
    data['calories'] = this.calories;
    data['fat'] = this.fat;
    data['carbs'] = this.carbs;
    data['protein'] = this.protein;
    return data;
  }
}
