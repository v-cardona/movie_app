part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class LoadVideoEvent extends VideosEvent {
  final int movieId;

  LoadVideoEvent({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}