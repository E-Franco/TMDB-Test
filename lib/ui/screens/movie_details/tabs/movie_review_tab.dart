import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/review.dart';
import '../../../../data/services/tmdb_api.dart';
import '../../../../stores/movie_details_store.dart';
import '../../../widgets/size_config_widget.dart';

class MoviewReviewTab extends StatelessWidget {
  final store = GetIt.I<MovieDetailsStore>();

  @override
  Widget build(BuildContext context) {
    return SizeConfigWidget(
      builder: (context, sizes) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: sizes.safeBlockHorizontal * 3,
            vertical: sizes.safeBlockVertical * 2,
          ),
          itemCount: store.reviews.length,
          itemBuilder: (context, index) {
            final review = store.reviews[index];
            return _ReviewCard(review: review);
          },
        );
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;

  _ReviewCard({
    this.review,
  });

  @override
  Widget build(BuildContext context) {
    bool hasAvatar = review.authorDetails.avatarPath != null;

    return SizeConfigWidget(
      builder: (context, sizes) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: sizes.safeBlockVertical * 0.5,
          ),
          child: Card(
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCardHeader(sizes, hasAvatar),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      review.content,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: sizes.safeBlockHorizontal * 3.5,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCardHeader(sizes, bool hasAvatar) {
    return Container(
      height: sizes.safeBlockVertical * 7,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: sizes.safeBlockHorizontal * 5,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: sizes.safeBlockHorizontal * 6,
              child: hasAvatar
                  ? null
                  : Icon(
                      Icons.person,
                      size: sizes.safeBlockHorizontal * 5,
                      color: Colors.black54,
                    ),
              backgroundImage: hasAvatar
                  ? CachedNetworkImageProvider(
                      formatAvatarUrl(review.authorDetails.avatarPath),
                    )
                  : null,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  review.author,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sizes.safeBlockHorizontal * 4,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(review.createdAt),
                  style: TextStyle(
                    fontSize: sizes.safeBlockHorizontal * 3.3,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          if (review.authorDetails.rating != null)
            Container(
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 10),
                  Text(
                    review.authorDetails.rating.toString(),
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: sizes.safeBlockHorizontal * 4,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  String formatAvatarUrl(String url) {
    // Possibilidade de url externo
    // Alguns iniciando em "/http"
    if (url.contains('http')) {
      if (url.startsWith('/')) {
        url = url.replaceFirst('/', '');
      }
    } else {
      url = TMDBApi.instance.api.images.getUrl(url);
    }

    return url;
  }
}
