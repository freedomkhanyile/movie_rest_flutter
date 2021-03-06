import 'package:movie_rest/models/movie/movie.dart';

class MovieResponse {
  late int page;
  late int totalResults;
  late int totalPages;
  late List<Movie> results;

  MovieResponse({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <Movie>[];
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
