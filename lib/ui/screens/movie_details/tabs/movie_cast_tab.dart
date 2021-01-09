import '../../../../data/model/actor.dart';
import '../../../../data/services/tmdb_api.dart';
import '../../../../stores/movie_details_store.dart';
import '../../../widgets/size_config_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCastTab extends StatelessWidget {
  final store = GetIt.I<MovieDetailsStore>();

  @override
  Widget build(BuildContext context) {
    return SizeConfigWidget(
      builder: (context, sizes) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: sizes.safeBlockVertical * 2,
            vertical: sizes.safeBlockVertical * 2,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: sizes.safeBlockHorizontal * 5,
            mainAxisSpacing: sizes.safeBlockHorizontal * 5,
          ),
          itemCount: store.cast.length,
          itemBuilder: (context, index) {
            final actor = store.cast[index];
            return _ActorCard(actor: actor);
          },
        );
      },
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard({
    Key key,
    @required this.actor,
  }) : super(key: key);

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return SizeConfigWidget(
      builder: (context, sizes) {
        return Card(
          color: Theme.of(context).accentColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: actor.profilePath == null
                      ? Center(
                          child: Icon(
                            Icons.person,
                            size: sizes.safeBlockHorizontal * 10,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: TMDBApi.instance.api.images.getUrl(actor.profilePath),
                          fit: BoxFit.cover,
                          placeholder: (context, label) => Image.memory(kTransparentImage),
                        ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        actor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizes.safeBlockHorizontal * 3.7,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        actor.character,
                        style: TextStyle(
                          fontSize: sizes.safeBlockHorizontal * 3,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
