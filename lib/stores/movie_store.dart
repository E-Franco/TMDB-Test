import 'package:mobx/mobx.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../data/model/movie.dart';
import '../data/services/tmdb_api.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStoreBase with _$MovieStore;

abstract class _MovieStoreBase with Store {
  @observable
  ObservableList<Movie> movies = ObservableList();

  int page = 1;

  _MovieStoreBase() {
    fetch();
  }

  @action
  Future<void> fetch() async {
    var response = await TMDBApi.instance.api.v3.discover.getMovies(
      primaryReleaseYear: 2020,
      sortBy: SortMoviesBy.voteCountDesc,
      page: page,
    );

    if (response.containsKey('results')) {
      List<Movie> movies = response['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
      this.movies.addAll(movies);

      page++;
    }
  }
}
