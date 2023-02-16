import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ["1", "2", "3"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
  );

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ["1", "2", "3"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
  );

  test('should be a subclass of tv show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
