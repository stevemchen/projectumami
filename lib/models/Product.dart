class Product {
  final int id;
  final String title;
  final double price;
  final double likes;
  final Nutrition nutrition;

  final String serving_size;
  final String description;
  final double ingredientCount;
  final String ingredientList;
  final List<Ingredients> ingredients;
  final List<String> images;

  Product(
      {this.id,
      this.title,
      this.price,
      this.likes,
      this.nutrition,
      this.serving_size,
      this.description,
      this.ingredientCount,
      this.ingredientList,
      this.ingredients,
      this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    var list = json['images'];
    List<String> listImages = list.cast<String>();
    // print('listImages length: ${listImages.length}');

    var list2 = json['ingredients'] as List;
    print(list.runtimeType);
    List<Ingredients> ingredientList =
        list2.map((i) => Ingredients.fromJson(i)).toList();

    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        likes: json['likes'],
        serving_size: json['serving_size'],
        description: json['description'],
        ingredientCount: json['ingredientCount'],
        ingredientList: json['ingredientList'],
        images: listImages,
        ingredients: ingredientList,
        nutrition: Nutrition.fromJson(json['nutrition']));
  }
}

class Ingredients {
  final String name;
  final String safety_level;
  final String description;

  Ingredients({this.name, this.safety_level, this.description});
  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      name: json['name'],
      safety_level: json['safety_level'],
      description: json['description'],
    );
  }
}

class Nutrition {
  final List<Nutrients> nutrients;
  final double calories;
  final String fat;
  final String protein;
  Nutrition({this.nutrients, this.calories, this.fat, this.protein});

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    var list4 = json['nutrients'] as List;
    List<Nutrients> listNutrients =
        list4.map((f) => Nutrients.fromJson(f)).toList();

    return Nutrition(
      nutrients: listNutrients,
      calories: json['calories'],
      fat: json['fat'],
      protein: json['protein'],
    );
  }
}

class Nutrients {
  final String title;
  final double amount;
  final String unit;
  final double percentOfDailyNeeds;

  Nutrients({this.title, this.amount, this.unit, this.percentOfDailyNeeds});

  factory Nutrients.fromJson(Map<String, dynamic> json) {
    return Nutrients(
      title: json['title'],
      amount: json['amount'],
      unit: json['unit'],
      percentOfDailyNeeds: json['percentOfDailyNeeds'],
    );
  }
}
