import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTvShowDetail(mockMovieRepository);
  });

  final tId = 1;

  test('should get tv show detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getTvShowsDetail(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvShowDetail));
  });
}
