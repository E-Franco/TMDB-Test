import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../data/services/tmdb_api.dart';
import '../../../stores/movie_details_store.dart';
import '../../widgets/size_config_widget.dart';
import '../home_screen.dart';
import 'tabs/movie_cast_tab.dart';
import 'tabs/movie_info_tab.dart';
import 'tabs/movie_review_tab.dart';

class MovieDetailsScreen extends StatefulWidget {
  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final store = GetIt.I<MovieDetailsStore>();
  bool loading = true;
  bool isLoaded = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500)).whenComplete(() => setState(() {
          loading = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SizeConfigWidget(
          builder: (context, sizes) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: TMDBApi.instance.api.images.getUrl(store.movie.backdropPath),
                                  fit: BoxFit.cover,
                                  // fadeInDuration: Duration.zero,
                                  // fadeOutDuration: Duration.zero,
                                  placeholder: (context, label) => Image.memory(
                                    kTransparentImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: sizes.safeBlockHorizontal * 40,
                                  top: sizes.safeBlockVertical * 2,
                                  right: sizes.safeBlockHorizontal * 5,
                                ),
                                constraints: BoxConstraints(
                                  minHeight: sizes.safeBlockVertical * 15,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        store.movie.title,
                                        style: TextStyle(
                                          fontSize: sizes.safeBlockHorizontal * 4.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(minHeight: 15, maxHeight: 20),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: sizes.safeBlockHorizontal * 10,
                                          height: sizes.safeBlockHorizontal * 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 4,
                                              color: Colors.green,
                                            ),
                                          ),
                                          alignment: FractionalOffset.center,
                                          child: Text(
                                            store.movie.voteAverage.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Released in',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: sizes.safeBlockHorizontal * 3,
                                              ),
                                            ),
                                            Text(
                                              DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                                                DateTime.parse(store.movie.releaseDate),
                                              ),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: sizes.safeBlockHorizontal * 3.5,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              margin: EdgeInsets.only(left: sizes.safeBlockHorizontal * 5),
                              width: sizes.safeBlockHorizontal * 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Card(
                                margin: EdgeInsets.zero,
                                shape: const StadiumBorder(side: BorderSide.none),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: TMDBApi.instance.api.images.getUrl(store.movie.posterPath),
                                    fit: BoxFit.cover,
                                    fadeInDuration: Duration.zero,
                                    fadeOutDuration: Duration.zero,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, sizes.safeBlockVertical * 2),
                            ),
                            Container(
                              color: Colors.white.withOpacity(0.05),
                              child: TabBar(
                                indicatorColor: Colors.white70,
                                tabs: [
                                  Tab(child: Text('Info')),
                                  Tab(child: Text('Cast')),
                                  Tab(child: Text('Reviews')),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  MovieInfoTab(),
                                  MovieCastTab(),
                                  MoviewReviewTab(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                AnimatedOpacity(
                  opacity: loading ? 1 : 0,
                  onEnd: () {
                    setState(() {
                      isLoaded = true;
                    });
                  },
                  child: isLoaded ? Container() : Container(color: Theme.of(context).primaryColor),
                  duration: Duration(milliseconds: 300),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
