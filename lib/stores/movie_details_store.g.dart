// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieDetailsStore on _MovieDetailsStoreBase, Store {
  final _$fetchCastAsyncAction =
      AsyncAction('_MovieDetailsStoreBase.fetchCast');

  @override
  Future<void> fetchCast() {
    return _$fetchCastAsyncAction.run(() => super.fetchCast());
  }

  final _$fetchReviewsAsyncAction =
      AsyncAction('_MovieDetailsStoreBase.fetchReviews');

  @override
  Future<void> fetchReviews() {
    return _$fetchReviewsAsyncAction.run(() => super.fetchReviews());
  }

  final _$_MovieDetailsStoreBaseActionController =
      ActionController(name: '_MovieDetailsStoreBase');

  @override
  void changeMovie(Movie value) {
    final _$actionInfo = _$_MovieDetailsStoreBaseActionController.startAction(
        name: '_MovieDetailsStoreBase.changeMovie');
    try {
      return super.changeMovie(value);
    } finally {
      _$_MovieDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
