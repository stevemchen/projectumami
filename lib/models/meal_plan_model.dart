import 'meal_model.dart';

class MealPlan {
  //MealPlan class has a list of meals and nutritional info about the meal plan
  final List<Meal> meals;
  final double calories, carbs, fat, protein;
  // final String ingredients;

  MealPlan({this.meals, this.calories, this.carbs, this.fat, this.protein});
  // MealPlan({this.meals, this.ingredients});

/*
The factory constructor iterates over the list of meals and our decoded mealplan
data and creates a list of meals.
Then, we return MealPlan object with all the information 
*/

  factory MealPlan.fromMap(Map<String, dynamic> map) {
    List<Meal> meals = [];
    // String ingredients = '';
    map['meals'].forEach((mealMap) => meals.add(Meal.fromMap(mealMap)));
    //MealPlan object with information we want
    return MealPlan(
        meals: meals,
        calories: map['nutrients']['calories'],
        carbs: map['nutrients']['carbohydrates'],
        fat: map['nutrients']['fat'],
        protein: map['nutrients']['protein']
        // ingredients: ingredients);
        );
  }
}
