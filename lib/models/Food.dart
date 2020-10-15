class Food {
  final List<Result> results;
  String baseUri;
  int offset;
  int number;
  int totalResults;

  Food(
      {this.results,
      this.baseUri,
      this.offset,
      this.number,
      this.totalResults});

  factory Food.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;

    List<Result> resultList = list.map((i) => Result.fromJson(i)).toList();

    return Food(
      results: resultList,
      baseUri: json['baseUri'],
      offset: json['offset'],
      number: json['number'],
      totalResults: json['totalResults'],
    );
  }
}

class Result {
  final int id;
  final String title;
  final int readyInMinutes;
  final int servings;
  final String image;

  Result({this.id, this.title, this.readyInMinutes, this.servings, this.image});

  factory Result.fromJson(Map<String, dynamic> parseJson) {
    /*  var streetsFromJson  = parseJson['imageUrls'];
    List<String> streetsList = streetsFromJson.cast<String>(); */
    return Result(
      id: parseJson['id'],
      title: parseJson['title'],
      readyInMinutes: parseJson['readyInMinutes'],
      servings: parseJson['servings'],
      image: parseJson['image'],
    );
  }
}

class Image {
  final List<String> images;
  Image({this.images});

  factory Image.fromJson(Map<String, dynamic> parseJson) {
    var streetsFromJson = parseJson['imageUrls'];

    List<String> streetsList = streetsFromJson.cast<String>();
    return new Image(images: streetsList);
  }
}
