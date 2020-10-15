class Ingredient {
  final String ingredient;
  final List<String> substitutes;
  final String message;

  Ingredient({this.ingredient, this.substitutes, this.message});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    var listSubstitesJson = json['substitutes'];

    List<String> listSub = listSubstitesJson.cast<String>();

    return Ingredient(
        ingredient: json['ingredient'],
        substitutes: listSub,
        message: json['message']);
  }
}
