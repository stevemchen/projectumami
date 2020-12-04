class Search {
  final List<Result> result;
  final String baseUri;
  final int totalResults;

  Search({this.result, this.baseUri, this.totalResults});

  factory Search.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;

    List<Result> listResult = list.map((f) => Result.fromJson(f)).toList();

    return Search(
        result: listResult,
        baseUri: json['baseUri'],
        totalResults: json['totalResults']);
  }
}

class Result {
  final int id;
  final String title;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final String image;

  Result(
      {this.id,
      this.title,
      this.readyInMinutes,
      this.servings,
      this.sourceUrl,
      this.image});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        id: json['id'],
        title: json['title'],
        readyInMinutes: json['readyInMinutes'],
        servings: json['servings'],
        sourceUrl: json['sourceUrl'],
        image: json['image']);
  }
}
