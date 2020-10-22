class NutrientID {
  final String calories;
  final String carbs;
  final String fat;
  final String protein;
  final List<Bad> bad;
  final List<Good> good;

  NutrientID(
      {this.calories, this.carbs, this.fat, this.protein, this.bad, this.good});
  factory NutrientID.fromJson(Map<String, dynamic> json) {
    var list = json['bad'] as List;
    var list2 = json['good'] as List;

    List<Bad> jsonBad = list.map((f) => Bad.fromJson(f)).toList();
    List<Good> jsonGood = list2.map((f) => Good.fromJson(f)).toList();

    return NutrientID(
      calories: json['calories'],
      carbs: json['carbs'],
      fat: json['fat'],
      protein: json['protein'],
      bad: jsonBad,
      good: jsonGood,
    );
  }
}

class Bad {
  final String title;
  final String amount;
  final bool indented;
  final double percentOfDailyNeeds;

  Bad({this.title, this.amount, this.indented, this.percentOfDailyNeeds});

  factory Bad.fromJson(Map<String, dynamic> json) {
    return Bad(
        title: json['title'],
        amount: json['amount'],
        indented: json['indented'],
        percentOfDailyNeeds: json['percentOfDailyNeeds'].toDouble());
  }
}

class Good {
  final String title;
  final String amount;
  final bool indented;
  final double percentOfDailyNeeds;

  Good({this.title, this.amount, this.indented, this.percentOfDailyNeeds});

  factory Good.fromJson(Map<String, dynamic> json) {
    return Good(
        title: json['title'],
        amount: json['amount'],
        indented: json['indented'],
        percentOfDailyNeeds: json['percentOfDailyNeeds'].toDouble());
  }
}
