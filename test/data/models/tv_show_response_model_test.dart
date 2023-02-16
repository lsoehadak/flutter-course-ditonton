import 'dart:convert';

import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

// TODO create tv_show_now_playing.json dummy
void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ["1", "2"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
  );

  final tTvShowResponseModel =
      TvShowResponse(tvShowList: <TvShowModel>[tTvShowModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1,
            "firstAirDate": "firstAirDate",
            "name": "name",
            "originCountry": ["1", "2"],
            "originalLanguage": "originalLanguage",
            "originalName": "originalName",
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
