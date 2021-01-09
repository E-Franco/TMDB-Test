// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GenreStore on _GenreStoreBase, Store {
  final _$fetchAsyncAction = AsyncAction('_GenreStoreBase.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$_GenreStoreBaseActionController =
      ActionController(name: '_GenreStoreBase');

  @override
  Genre find(int id) {
    final _$actionInfo = _$_GenreStoreBaseActionController.startAction(
        name: '_GenreStoreBase.find');
    try {
      return super.find(id);
    } finally {
      _$_GenreStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
