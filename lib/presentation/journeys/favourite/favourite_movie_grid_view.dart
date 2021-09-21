import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

import 'favourite_movie_card_widget.dart';

class FavouriteMovieGridView extends StatelessWidget {
  final List<MovieEntity> movies;

  const FavouriteMovieGridView({
    Key key,
    @required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.dimen_8.w,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: Sizes.dimen_16.w,
        ),
        itemBuilder: (context, index) {
          return FavouriteMovieCardWidget(
            movie: movies[index],
          );
        },
      ),
    );
  }
}
