import 'package:flutter/material.dart';
import 'package:movie_rest/blocs/movie/movieDetailBloc.dart';
import 'package:movie_rest/models/movie/movie.dart';
import 'package:movie_rest/networking/apiResponse.dart';
import 'package:movie_rest/view/shared/errorScreen.dart';
import 'package:movie_rest/view/shared/loadingScreen.dart';
import 'dart:ui' as ui;

class MovieDetail extends StatefulWidget {
  final int movieId;
  MovieDetail({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "MovieR | view",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: RefreshIndicator(
        onRefresh: () => _movieDetailBloc.fetchMovieDetail(widget.movieId),
        child: StreamBuilder<ApiResponse<Movie>>(
          stream: _movieDetailBloc.movieDetailStream,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              switch (snapShot.data!.status) {
                case Status.LOADING:
                  return LoadingScreen(loadigMessage: snapShot.data!.message);
                case Status.COMPLETED:
                  return MovieDetailBody(
                    movie: snapShot.data!.data,
                  );
                case Status.ERROR:
                  return ErrorScreen(
                    errorMessage: snapShot.data!.message,
                    press: () =>
                        _movieDetailBloc.fetchMovieDetail(widget.movieId)(),
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

class MovieDetailBody extends StatelessWidget {
  final Movie movie;
  const MovieDetailBody({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          new Image.network(
            'https://image.tmdb.org/t/p/w342${movie.posterPath}',
            fit: BoxFit.cover,
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: new Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          new SingleChildScrollView(
            child: new Container(
              margin: const EdgeInsets.all(20.0),
              child: new Column(
                children: [
                  new Container(
                    alignment: Alignment.center,
                    child: new Container(
                      width: 400.0,
                      height: 400.0,
                    ),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      image: new DecorationImage(
                          image: new NetworkImage(
                              'https://image.tmdb.org/t/p/w342${movie.posterPath}'),
                          fit: BoxFit.cover),
                      boxShadow: [
                        new BoxShadow(
//                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: new Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 0.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                          movie.title,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'Arvo'),
                        )),
                        new Text(
                          movie.voteAverage.toStringAsFixed(2),
//                      '${widget.movie['vote_average']}/10',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Arvo'),
                        )
                      ],
                    ),
                  ),
                  new Text(
                    movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style:
                        new TextStyle(color: Colors.white, fontFamily: 'Arvo'),
                  ),
                  new Padding(padding: const EdgeInsets.all(10.0)),
                  new Row(
                    children: [
                      new Expanded(
                        child: new Container(
                            width: 150.0,
                            height: 60.0,
                            alignment: Alignment.center,
                            child: new Text(
                              'Rate Movie',
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Arvo',
                                  fontSize: 20.0),
                            ),
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(10.0),
                                color: Colors.purpleAccent.withOpacity(0.3))),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: new Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: new Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
