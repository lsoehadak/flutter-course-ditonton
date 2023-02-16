import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetNowPlayingTvShows {
  final MovieRepository repository;

  GetNowPlayingTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getNowPlayingTvShows();
  }
}
