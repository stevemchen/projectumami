class RDRecipe {
  final List<Recipe> recipes;

  RDRecipe({this.recipes});

  factory RDRecipe.fromJson(Map<String, dynamic> parseJson) {
    var list = parseJson['recipes'] as List;
    List<Recipe> recipesList = list.map((f) => Recipe.fromJson(f)).toList();

    return RDRecipe(recipes: recipesList);
  }
}

class Recipe {
  final String spoonacularSourceUrl;
  final double spoonacularScore;
  final double healthScore;
  final String creditsText;
  final double pricePerServing;
  final List<Ingredient> extendedIngredients;

  Recipe(
      {this.spoonacularSourceUrl,
      this.spoonacularScore,
      this.healthScore,
      this.creditsText,
      this.pricePerServing,
      this.extendedIngredients});

  factory Recipe.fromJson(Map<String, dynamic> parseJson) {
    var list = parseJson['extendedIngredients'] as List;

    List<Ingredient> listExtend =
        list.map((i) => Ingredient.fromJson(i)).toList();

    return Recipe(
        spoonacularSourceUrl: parseJson['spoonacularSourceUrl'],
        spoonacularScore: parseJson['spoonacularScore'],
        healthScore: parseJson['healthScore'],
        creditsText: parseJson['creditsText'],
        pricePerServing: parseJson['pricePerServing'],
        extendedIngredients: listExtend);
  }
}

class Ingredient {
  final int id;
  final String name;
  final String original;
  final double amount;
  final Measure measure;
  Ingredient({this.id, this.name, this.original, this.amount, this.measure});

  factory Ingredient.fromJson(Map<String, dynamic> parseJson) {
    return Ingredient(
      id: parseJson['id'],
      name: parseJson['name'],
      original: parseJson['original'],
      amount: parseJson['amount'],
      measure: parseJson['measure'],
    );
  }
}

class Measure {
  final US us;
  final Metric metric;
  Measure({this.us, this.metric});

  factory Measure.fromJson(Map<String, dynamic> parseJson) {
    return Measure(
        us: US.fromJson(parseJson['us']),
        metric: Metric.fromJson(parseJson['metric']));
  }
}

class US {
  double amount;
  String unitShort;
  US({this.amount, this.unitShort});
  factory US.fromJson(Map<String, dynamic> parseJson) {
    return US(amount: parseJson['amount'], unitShort: parseJson['unitShort']);
  }
}

class Metric {
  final double amount;
  final String unitShort;
  Metric({this.amount, this.unitShort});

  factory Metric.fromJson(Map<String, dynamic> parseJson) {
    return Metric(
        amount: parseJson['amount'], unitShort: parseJson['unitShort']);
  }
}
