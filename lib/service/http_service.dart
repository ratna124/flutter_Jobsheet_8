import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_request/model/movie.dart';

class HttpService {
  final String apiKey = '8971f3f709abda8d0058eeaa82b9a1d1';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/550?api_key';

  Future<List> getPopularMovies() async {
    final String uri = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      print("Sukses");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print("Fail");
      return null;
    }
  }
}
