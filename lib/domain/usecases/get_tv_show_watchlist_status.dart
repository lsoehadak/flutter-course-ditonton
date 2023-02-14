import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetTvShowWatchListStatus {
  final MovieRepository repository;

  GetTvShowWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isTvShowAddedToWatchlist(id);
  }
}
