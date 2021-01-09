import 'package:mobx/mobx.dart';

import '../data/model/actor.dart';
import '../data/model/movie.dart';
import '../data/model/review.dart';
import '../data/services/tmdb_api.dart';

part 'movie_details_store.g.dart';

class MovieDetailsStore = _MovieDetailsStoreBase with _$MovieDetailsStore;

abstract class _MovieDetailsStoreBase with Store {
  Movie movie;
  List<Actor> cast;
  List<Review> reviews;

  @action
  void changeMovie(Movie value) {
    movie = value;
    fetchCast();
    fetchReviews();
  }

  @action
  Future<void> fetchCast() async {
    try {
      var response = await TMDBApi.instance.api.v3.movies.getCredits(movie.id);
      if (response.containsKey('cast')) {
        cast = response['cast'].map<Actor>((c) => Actor.fromJson(c)).toList();
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> fetchReviews() async {
    try {
      var response = await TMDBApi.instance.api.v3.movies.getReviews(movie.id);
      if (response.containsKey('results')) {
        reviews = response['results'].map<Review>((r) => Review.fromJson(r)).toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
