import 'package:hive/hive.dart';
import 'package:movie_app/data/tables/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<void> saveMovie(MovieTable movieTable);
  Future<List<MovieTable>> getMovies();
  Future<void> deleteMovie(int movieId);
  Future<bool> checkIfMovieFavourite(int movieId);
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  @override
  Future<bool> checkIfMovieFavourite(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    return movieBox.containsKey(movieId);
  }

  @override
  Future<void> deleteMovie(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getMovies() async {
    final movieBox = await Hive.openBox('movieBox');
    final moviesIds = movieBox.keys;
    List<MovieTable> movies = [];
    moviesIds.forEach((movieId) {
      final movie = movieBox.get(movieId);
      if (movie != null) {
        movies.add(movie);
      }
    });
    return movies;
  }

  @override
  Future<void> saveMovie(MovieTable movieTable) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.put(movieTable.id, movieTable);
  }
}
