import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/get_playing_now.dart';
import 'package:movie_app/domain/usecases/get_popular.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:test/test.dart';

class GetPopularMock extends Mock implements GetPopular {}

class GetPlayingNowMock extends Mock implements GetPlayingNow {}

class GetComingSoonMock extends Mock implements GetComingSoon {}

main() {
  GetPopularMock getPopularMock;
  GetPlayingNowMock getPlayingNowMock;
  GetComingSoonMock getComingSoonMock;

  MovieTabbedCubit movieTabbedCubit;

  setUp(() {
    getPopularMock = GetPopularMock();
    getPlayingNowMock = GetPlayingNowMock();
    getComingSoonMock = GetComingSoonMock();

    movieTabbedCubit = MovieTabbedCubit(
      getComingSoon: getComingSoonMock,
      getPlayingNow: getPlayingNowMock,
      getPopular: getPopularMock,
    );
  });

  tearDown(() {
    movieTabbedCubit.close();
  });

  test('bloc should have initial state as [MovieTabbedInitial]', () {
    expect(movieTabbedCubit.state.runtimeType, MovieTabbedInitial);
  });

  blocTest(
    'should emit [MovieTabLoading] and [MovieTabChanged] when playing now tab changed success',
    build: () => movieTabbedCubit,
    act: (MovieTabbedCubit cubit) {
      when(getPlayingNowMock.call(NoParams()))
          .thenAnswer((realInvocation) async => Right([]));
      cubit.changeTabMovie(currentTabIndex: 1);
    },
    expect: [
      isA<MovieTabLoading>(),
      isA<MovieTabChanged>(),
    ],
    verify: (MovieTabbedCubit cubit) {
      verify(getPlayingNowMock.call(any)).called(1);
    },
  );

  blocTest(
    'should emit [MovieTabLoading] and [MovieTabChanged] when popular tab changed success',
    build: () => movieTabbedCubit,
    act: (MovieTabbedCubit cubit) {
      when(getPopularMock.call(NoParams()))
          .thenAnswer((realInvocation) async => Right([]));
      cubit.changeTabMovie(currentTabIndex: 0);
    },
    expect: [
      isA<MovieTabLoading>(),
      isA<MovieTabChanged>(),
    ],
    verify: (MovieTabbedCubit cubit) {
      verify(getPopularMock.call(any)).called(1);
    },
  );

  blocTest(
    'should emit [MovieTabLoading] and [MovieTabChanged] when coming soon tab changed success',
    build: () => movieTabbedCubit,
    act: (MovieTabbedCubit cubit) {
      when(getComingSoonMock.call(NoParams()))
          .thenAnswer((realInvocation) async => Right([]));
      cubit.changeTabMovie(currentTabIndex: 2);
    },
    expect: [
      isA<MovieTabLoading>(),
      isA<MovieTabChanged>(),
    ],
    verify: (MovieTabbedCubit cubit) {
      verify(getComingSoonMock.call(any)).called(1);
    },
  );

  blocTest(
    'should emit [MovieTabLoading] and [MovieTabLoadError] when coming soon tab changed fail',
    build: () => movieTabbedCubit,
    act: (MovieTabbedCubit cubit) {
      when(getComingSoonMock.call(NoParams())).thenAnswer(
          (realInvocation) async => Left(AppError(AppErrorType.api)));
      cubit.changeTabMovie(currentTabIndex: 2);
    },
    expect: [
      isA<MovieTabLoading>(),
      isA<MovieTabLoadError>(),
    ],
    verify: (MovieTabbedCubit cubit) {
      verify(getComingSoonMock.call(any)).called(1);
    },
  );
}
