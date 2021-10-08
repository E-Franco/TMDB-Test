import '../../resources/colors.dart';
import '../widgets/size_config_widget.dart';

import '../../data/model/movie.dart';
import '../../data/services/tmdb_api.dart';
import '../../stores/movie_store.dart';
import '../widgets/card_flip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MovieStore _movieStore = MovieStore();
  ScrollController _scrollController;
  bool display = false;

  @override
  void initState() {
    // List infinita
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge && _scrollController.position.pixels > 0) {
        _movieStore.fetch();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      extendBody: true,
      body: SizeConfigWidget(
        builder: (context, sizes) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeView())),
                child: Container(
                  alignment: FractionalOffset.centerRight,
                  padding: EdgeInsets.symmetric(
                    vertical: sizes.safeBlockVertical * 3,
                    horizontal: sizes.safeBlockHorizontal * 3,
                  ),
                  height: sizes.safeBlockVertical * 15,
                  child: Image.asset('assets/tmdb.png'),
                ),
              ),
              Observer(
                builder: (_) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: EdgeInsets.all(sizes.safeBlockHorizontal * 3),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _movieStore.movies.length,
                    itemBuilder: (context, index) {
                      final movie = _movieStore.movies[index];
                      return Hero(
                        tag: movie.id,
                        child: CardFlip(
                          movie: movie,
                          frontWidget: buildFrontWidget(movie),
                          backWidget: buildBackWidget(context),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildBackWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).accentColor,
      ),
    );
  }

  Widget buildFrontWidget(Movie movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: TMDBApi.instance.api.images.getUrl(movie.posterPath),
        placeholder: (context, label) => Image.memory(kTransparentImage),
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
      ),
    );
  }
}
