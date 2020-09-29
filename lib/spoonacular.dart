import 'package:http/http.dart' as http;

void spoonacular_get(Map request) async {
  // API Key. Currently using Jerry's (free tier, 150 calls per day)
  String apiKey = "46b60620dcee4f78aba8730bd9f9fcae";
  // GET HTTP Request URL
  String url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=";
  url += apiKey;
  // Affix and call HTTP GET
  for (String k in request.keys) {
    url += "&" + k + "=" + request[k];
  }
  var response = await http.get(url);
  // Print response
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

void main() {
  // Request body. Stored in Map data type
  var request = {'ingredients': "apple, flour, sugar", 'number': "2"};
  spoonacular_get(request);
}