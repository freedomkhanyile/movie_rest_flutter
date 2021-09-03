import 'package:movie_rest/apiKey.dart';
import 'package:movie_rest/models/movie/movie.dart';
import 'package:movie_rest/networking/apiBaseHelper.dart';

class MovieDetailRepository {
  final String _apiKey = apiKey!;

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Movie> fetchMovieDetail(int movieId) async {
    final response = await _helper.get("movie/$movieId?api_key=$_apiKey");
    return Movie.fromJson(response);
  }
}
