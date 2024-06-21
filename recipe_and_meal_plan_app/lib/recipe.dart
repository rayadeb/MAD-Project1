class Recipe {
  String? name;
  String? url;
  String? description;
  String? author;
  List<String>? ingredients;
  List<String>? method;

  Recipe(
      {this.name,
      this.url,
      this.description,
      this.author,
      this.ingredients,
      this.method});

  Recipe.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    url = json['url'];
    description = json['Description'];
    author = json['Author'];
    ingredients = json['Ingredients'].cast<String>();
    method = json['Method'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['url'] = this.url;
    data['Description'] = this.description;
    data['Author'] = this.author;
    data['Ingredients'] = this.ingredients;
    data['Method'] = this.method;
    return data;
  }
}
