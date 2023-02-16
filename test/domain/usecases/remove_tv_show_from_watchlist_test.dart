import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvShowFromWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveTvShowFromWatchlist(mockMovieRepository);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockMovieRepository.removeTvShowFromWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockMovieRepository.removeTvShowFromWatchlist(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
