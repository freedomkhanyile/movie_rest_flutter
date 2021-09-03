import 'dart:async';

import 'package:movie_rest/models/movie/movie.dart';
import 'package:movie_rest/networking/apiResponse.dart';
import 'package:movie_rest/repository/movie/movieDetailRepository.dart';

class MovieDetailBloc {

  late MovieDetailRepository _movieDetailRepository;
  late StreamController<ApiResponse<Movie>> _movieDetailController;

  MovieDetailBloc(movieId) {
    _movieDetailController = StreamController<ApiResponse<Movie>>();
    _movieDetailRepository = MovieDetailRepository();
    fetchMovieDetail(movieId);
  }

  StreamSink<ApiResponse<Movie>> get movieDetailSink =>
      _movieDetailController.sink;
  Stream<ApiResponse<Movie>> get movieDetailStream =>
      _movieDetailController.stream;

  fetchMovieDetail(int selectedMovie) async {
    movieDetailSink.add(ApiResponse.loading('Fetching Details'));
    try {
      Movie details =
          await _movieDetailRepository.fetchMovieDetail(selectedMovie);
      movieDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      movieDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieDetailController.close();
  }
  
}
