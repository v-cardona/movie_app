import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/blocs/favourite/favourite_bloc.dart';

import 'favourite_movie_grid_view.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteCubit _favouriteCubit;

  @override
  void initState() {
    super.initState();
    _favouriteCubit = getItInstance<FavouriteCubit>();
    _favouriteCubit.loadFavouriteMovies();
  }

  @override
  void dispose() {
    super.dispose();
    _favouriteCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationConstants.favoriteMovies.translate(context),
        ),
      ),
      body: BlocProvider.value(
        value: _favouriteCubit,
        child: BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            if (state is FavouriteMoviesLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text(
                      TranslationConstants.noFavouritesMovies
                          .translate(context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1),
                );
              } else {
                return FavouriteMovieGridView(
                  movies: state.movies,
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
