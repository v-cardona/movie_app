import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/language_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/app_repository_impl.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/check_if_favourite_movie.dart';
import 'package:movie_app/domain/usecases/delete_favourite_movie.dart';
import 'package:movie_app/domain/usecases/get_cast.dart';
import 'package:movie_app/domain/usecases/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/get_favourites_movies.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/domain/usecases/get_playing_now.dart';
import 'package:movie_app/domain/usecases/get_popular.dart';
import 'package:movie_app/domain/usecases/get_preferred_language.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/domain/usecases/get_videos.dart';
import 'package:movie_app/domain/usecases/save_movie.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/domain/usecases/update_language.dart';
import 'package:movie_app/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/favourite/favourite_bloc.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());

  // init usecases
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetVideos>(
    () => GetVideos(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<SaveMovie>(
    () => SaveMovie(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<GetFavouritesMovies>(
    () => GetFavouritesMovies(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<DeleteFavouriteMovie>(
    () => DeleteFavouriteMovie(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<CheckIfFavouriteMovie>(
    () => CheckIfFavouriteMovie(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<UpdateLanguage>(
    () => UpdateLanguage(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<GetPreferredLanguage>(
    () => GetPreferredLanguage(
      getItInstance(),
    ),
  );
  // movie repository
  getItInstance.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      getItInstance(),
      getItInstance(),
    ),
  );
  // app repository
  getItInstance.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      getItInstance(),
    ),
  );

  // bloc
  getItInstance.registerFactory(() => MovieCarouselBloc(
      getTrending: getItInstance(), movieBackdropBloc: getItInstance()));
  getItInstance.registerLazySingleton(() => MovieBackdropBloc());
  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      getPopular: getItInstance(),
      getComingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<LanguageBloc>(
    LanguageBloc(
      getPreferredLanguage: getItInstance(),
      updateLanguage: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosBloc: getItInstance(),
      favouriteBloc: getItInstance(),
    ),
  );
  getItInstance.registerFactory(() => CastBloc(getCast: getItInstance()));
  getItInstance.registerFactory(() => VideosBloc(getVideos: getItInstance()));

  getItInstance
      .registerFactory(() => SearchMovieBloc(searchMovies: getItInstance()));
  getItInstance.registerFactory(
    () => FavouriteBloc(
      saveMovie: getItInstance(),
      getFavouritesMovies: getItInstance(),
      deleteFavouriteMovie: getItInstance(),
      checkIfFavouriteMovie: getItInstance(),
    ),
  );
}
