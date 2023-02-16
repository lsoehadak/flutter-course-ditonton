import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvShowToWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveTvShowToWatchlist(mockMovieRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockMovieRepository.saveTvShowToWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockMovieRepository.saveTvShowToWatchlist(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
