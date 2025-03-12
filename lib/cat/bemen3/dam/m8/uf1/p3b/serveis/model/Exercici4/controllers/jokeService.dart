import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici4/models/joke.dart';

class JokeService {
  static Future<Joke?> fetchRandomJoke() async {
    try {
      final response = await http.get(Uri.parse('https://api.sampleapis.com/jokes/goodJokes'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Joke> jokes = jsonList.map((json) => Joke.fromJson(json)).toList();
        if (jokes.isEmpty) return null;
        return jokes[Random().nextInt(jokes.length)];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
