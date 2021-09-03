import 'package:flutter/material.dart';
import 'package:movie_rest/blocs/movie/movieBloc.dart';
import 'package:movie_rest/models/movie/movie.dart';
import 'package:movie_rest/networking/apiResponse.dart';
import 'package:movie_rest/view/movie/movieDetailScreen.dart';
import 'package:movie_rest/view/shared/errorScreen.dart';
import 'package:movie_rest/view/shared/loadingScreen.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late MovieBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'MovieR | App',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchMovieList(),
        child: StreamBuilder<ApiResponse<List<Movie>>>(
          stream: _bloc.movieListStream,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              switch (snapShot.data!.status) {
                case Status.LOADING:
                  return LoadingScreen(loadigMessage: snapShot.data!.message);
                case Status.COMPLETED:
                  return MovieList(movieList: snapShot.data!.data);
                case Status.ERROR:
                  return ErrorScreen(
                    errorMessage: snapShot.data!.message,
                    press: () => _bloc.fetchMovieList(),
                  );
              }
            }

            return Container();
          },
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList;

  const MovieList({
    Key? key,
    required this.movieList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
               Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => MovieDetail(
                          movieId: movieList[index].id,
                        ),),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
