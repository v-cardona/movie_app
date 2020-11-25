import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movies_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day');
    List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }
  
  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await _client.get('movie/popular');
    List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final response = await _client.get('movie/epcoming');
    List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await _client.get('movie/now_playing');
    List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }
}