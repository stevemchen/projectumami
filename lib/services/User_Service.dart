import 'package:umami/services/User.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class UserService {
  static const String url = "https://jsonplaceholder.typicode.com/posts";
  static Future<List<User>> getUser() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<User> food2s = userFromJson(response.body);
        return food2s;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }
}
