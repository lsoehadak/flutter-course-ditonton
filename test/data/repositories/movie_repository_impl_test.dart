import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvShowModel = TvShowModel(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ["1", "2"],
    originalLanguage: 'originalanguage',
    originalName: 'originalName',
  );

  final tTvShow = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ["1", "2"],
    originalLanguage: 'originalanguage',
    originalName: 'originalName',
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getPopularMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });

  group('Now Playing Tv Shows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getNowPlayingTvShows();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvShows();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvShows();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Shows', () {
    test('should return tv show list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getPopularTvShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvShows();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvShows();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Shows', () {
    test('should return tv show list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Show Detail', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailModel(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      id: 1,
      originalLanguage: 'en',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1,
      voteCount: 1,
      episodeRunTime: [],
      firstAirDate: DateTime(2000),
      inProduction: true,
      languages: ["en"],
      lastAirDate: DateTime(2000),
      name: 'name',
      originalName: 'originalName',
      type: 'type',
    );

    test(
        'should return TvShow data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenAnswer((_) async => tTvShowResponse);
      // act
      final result = await repository.getTvShowsDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Right(testTvShowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowsDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowsDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test('should return data (tv show list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenAnswer((_) async => tTvShowList);
          // act
          final result = await repository.getTvShowsRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvShowList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvShowsRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvShowsRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Search Tv Shows', () {
    final tQuery = 'name';

    test('should return tv show list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenAnswer((_) async => tTvShowModelList);
          // act
          final result = await repository.searchTvShows(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTvShows(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTvShows(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Save tv show to watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowToWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTvShowToWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowToWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTvShowToWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove tv show from watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowFromWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTvShowFromWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowFromWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTvShowFromWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get tv show watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isTvShowAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Get watchlist tv shows', () {
    test('should return list of Tv shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShow())
          .thenAnswer((_) async => [testTvShowTable]);
      // act
      final result = await repository.getWatchlistTvShows();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}
