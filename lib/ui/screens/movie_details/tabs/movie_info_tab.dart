import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../stores/genre_store.dart';
import '../../../../stores/movie_details_store.dart';
import '../../../widgets/size_config_widget.dart';

class MovieInfoTab extends StatelessWidget {
  final store = GetIt.I<MovieDetailsStore>();
  final genreStore = GetIt.I<GenreStore>();

  @override
  Widget build(BuildContext context) {
    return SizeConfigWidget(builder: (context, sizes) {
      return Container(
        padding: EdgeInsets.all(sizes.safeBlockHorizontal * 5),
        child: Text(
          store.movie.overview,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: sizes.safeBlockHorizontal * 4,
            color: Colors.white70,
          ),
        ),
      );
    });
  }
}
