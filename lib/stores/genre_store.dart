import 'package:mobx/mobx.dart';

import '../data/model/genre.dart';
import '../data/services/tmdb_api.dart';

part 'genre_store.g.dart';

class GenreStore = _GenreStoreBase with _$GenreStore;

abstract class _GenreStoreBase with Store {
  _GenreStoreBase() {
    fetch();
  }

  List<Genre> genres;

  @action
  Genre find(int id) => genres.firstWhere((g) => g.id == id);

  @action
  Future<void> fetch() async {
    try {
      var response = await TMDBApi.instance.api.v3.geners.getMovieList();
      if (response.containsKey('genres')) {
        genres = response['genres'].map<Genre>((g) => Genre.fromJson(g)).toList();
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
