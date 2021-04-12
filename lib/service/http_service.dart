import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tugas9/models/movie.dart';

class HttpService {
  final String apiKey = 'a3286d35e3fc04934fff4d654513737e';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=a3286d35e3fc04934fff4d654513737e';

  Future<List> getPopularMovies() async{
    final String uri = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok){
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