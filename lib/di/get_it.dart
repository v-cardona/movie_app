import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/authentication_local_data_source.dart';
import 'package:movie_app/data/data_sources/authentication_remote_data_source.dart';
import 'package:movie_app/data/data_sources/language_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/data_sources/theme_local_data_source.dart';
import 'package:movie_app/data/repositories/app_repository_impl.dart';
import 'package:movie_app/data/repositories/authentication_repository_impl.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/repositories/authentication_repository.dart';
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
import 'package:movie_app/domain/usecases/get_preferred_theme.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/domain/usecases/get_videos.dart';
import 'package:movie_app/domain/usecases/login_user.dart';
import 'package:movie_app/domain/usecases/logout_user.dart';
import 'package:movie_app/domain/usecases/save_movie.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/domain/usecases/update_language.dart';
import 'package:movie_app/domain/usecases/update_theme.dart';
import 'package:movie_app/presentation/blocs/cast/cast_cubit.dart';
import 'package:movie_app/presentation/blocs/favourite/favourite_bloc.dart';
import 'package:movie_app/presentation/blocs/language/language_cubit.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';
import 'package:movie_app/presentation/blocs/login/login_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/blocs/videos/videos_cubit.dart';

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
  getItInstance.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

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
  getItInstance.registerLazySingleton<LoginUser>(
    () => LoginUser(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<LogoutUser>(
    () => LogoutUser(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<GetPreferredTheme>(
    () => GetPreferredTheme(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<UpdateTheme>(
    () => UpdateTheme(
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
      getItInstance(),
    ),
  );
  // authentication repository
  getItInstance.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      getItInstance(),
      getItInstance(),
    ),
  );

  // bloc
  getItInstance.registerSingleton<LoadingCubit>(
    LoadingCubit(),
  );
  getItInstance.registerLazySingleton(() => MovieBackdropCubit());
  getItInstance.registerFactory(() => MovieCarouselCubit(
        getTrending: getItInstance(),
        movieBackdropCubit: getItInstance(),
        loadingCubit: getItInstance(),
      ));
  getItInstance.registerFactory(
    () => MovieTabbedCubit(
      getPopular: getItInstance(),
      getComingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<LanguageCubit>(
    LanguageCubit(
      getPreferredLanguage: getItInstance(),
      updateLanguage: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<LoginCubit>(
    LoginCubit(
      loginUser: getItInstance(),
      logoutUser: getItInstance(),
      loadingCubit: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MovieDetailCubit(
      loadingCubit: getItInstance(),
      getMovieDetail: getItInstance(),
      castCubit: getItInstance(),
      videosCubit: getItInstance(),
      favouriteCubit: getItInstance(),
    ),
  );
  getItInstance.registerFactory(() => CastCubit(getCast: getItInstance()));
  getItInstance.registerFactory(() => VideosCubit(getVideos: getItInstance()));

  getItInstance.registerFactory(() => SearchMovieCubit(
        loadingCubit: getItInstance(),
        searchMovies: getItInstance(),
      ));
  getItInstance.registerFactory(
    () => FavouriteCubit(
      saveMovie: getItInstance(),
      getFavouritesMovies: getItInstance(),
      deleteFavouriteMovie: getItInstance(),
      checkIfFavouriteMovie: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => ThemeCubit(
      getPreferredTheme: getItInstance(),
      updateTheme: getItInstance(),
    ),
  );
}
