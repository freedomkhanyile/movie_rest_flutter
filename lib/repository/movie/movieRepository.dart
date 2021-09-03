 import 'package:movie_rest/models/movie/movie.dart';
import 'package:movie_rest/models/movie/movieResponse.dart';
import 'package:movie_rest/networking/apiBaseHelper.dart';
 import 'package:movie_rest/apiKey.dart';

 
class MovieRepository {
  final String _apiKey = apiKey!;

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
  
}