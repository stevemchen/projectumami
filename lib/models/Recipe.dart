class Recipes {
  final List<Recipe> recipes;
  final length;
  Recipes({this.recipes, this.length});
  factory Recipes.fromJson(Map<String, dynamic> json) {
    var list = json['recipes'] as List;
    print('object list: ${list.length}');
    var listRecipes = list.map((f) => Recipe.fromJson(f)).toList();
    print('object list2: ${listRecipes.length}');
    return Recipes(
      recipes: listRecipes,
    );
  }
}

class Recipe {
  final String sourceUrl;
  final String sourceName;
  final double pricePerServing;

  Recipe({this.sourceUrl, this.sourceName, this.pricePerServing});

  factory Recipe.fromJson(Map<String, dynamic> parseJson) {
    return (Recipe(
      sourceUrl: parseJson['sourceUrl'],
      sourceName: parseJson['sourceName'],
      pricePerServing: parseJson['pricePerServing'],
    ));
  }
}
