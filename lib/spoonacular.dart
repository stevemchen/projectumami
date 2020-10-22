import 'dart:convert';
import 'package:http/http.dart' as http;

/// Obtains information regarding recipes given request type and request input.
/// All request bodies must follow the form:
/// {
///   "number" : String,
///   "body" : {
///     "parameter_1" : String,
///     "parameter_2" : String
///     // ...
///   }
/// }
/// Parameters in body field must follow the form on https://spoonacular.com/food-api/docs#Search-Recipes-Complex.

String apiKey = "46b60620dcee4f78aba8730bd9f9fcae";

Future<Map> spoonacularGet(Map request) async {

  // Setup HTTP-GET URL
  String url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=";
  url += apiKey;

  // Setup number of results
  url += "&number=" + request["number"];

  // Affix and call HTTP GET
  for (String k in request["body"].keys) {
    url += "&" + k + "=" + request["body"][k];
  }

  print(url);

  var response = await http.get(url);

  // Print response (comment out on prod)
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  // Return response body for further usage
  return jsonDecode(response.body);
}

Future<String> retrieveRecipe(String id) async {

  // Setup HTTP-GET URL
  String url = "https://api.spoonacular.com/recipes/" + id + "/information?apiKey=" + apiKey;

  // Call HTTP GET
  var response = await http.get(url);

  // Find recipe sourceURL
  String sourceURL = jsonDecode(response.body)["sourceUrl"];

  // Print response
  print('Response status: ${response.statusCode}');
  print('Source URL: $sourceURL');

  return sourceURL;
}

Future<void> main() async {
  // Request body example
  var request = {"number": "2", "body": {"includeIngredients": "apple, sugar"}};
  var result = await spoonacularGet(request);
  var recipe = retrieveRecipe(result["results"][0]["id"].toString());
}