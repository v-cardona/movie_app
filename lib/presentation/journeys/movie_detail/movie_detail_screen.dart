import 'package:flutter/material.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguments.dart';

class MovieDetailScreen extends StatelessWidget {

  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({
    Key key,
    @required this.movieDetailArguments
  }) : assert (movieDetailArguments != null, 'arguments must not be null'),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}