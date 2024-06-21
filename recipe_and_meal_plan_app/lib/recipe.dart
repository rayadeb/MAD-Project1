class Recipe {
  String? author;
  int? cookTimeMinutes;
  String? description;
  bool? error;
  List<String>? footnotes;
  List<String>? ingredients;
  List<String>? instructions;
  String? photoUrl;
  int? prepTimeMinutes;
  int? ratingStars;
  int? reviewCount;
  int? timeScraped;
  String? title;
  int? totalTimeMinutes;
  String? url;

  Recipe(
      {this.author,
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
      this.url});

  Recipe.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    cookTimeMinutes = json['cook_time_minutes'];
    description = json['description'];
    error = json['error'];
    footnotes = json['footnotes'].cast<String>();
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'].cast<String>();
    photoUrl = json['photo_url'];
    prepTimeMinutes = json['prep_time_minutes'];
    ratingStars = json['rating_stars'];
    reviewCount = json['review_count'];
    timeScraped = json['time_scraped'];
    title = json['title'];
    totalTimeMinutes = json['total_time_minutes'];
    url = json['url'];
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
    return data;
  }
}
