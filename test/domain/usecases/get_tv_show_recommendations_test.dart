import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVShowRecommendations usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTVShowRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tTvShow = <TvShow>[];

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getTvShowsRecommendations(tId))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvShow));
  });
}
