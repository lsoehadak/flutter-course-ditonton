import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class SaveTvShowToWatchlist {
  final MovieRepository repository;

  SaveTvShowToWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.saveTvShowToWatchlist(tvShow);
  }
}
