import 'package:umami/services/User2.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class User2Service {
  static const String url = "https://jsonplaceholder.typicode.com/users";
  static Future<List<User2>> getUser() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<User2> food2s = user2FromJson(response.body);
        return food2s;
      } else {
        return List<User2>();
      }
    } catch (e) {
      return List<User2>();
    }
  }
}
