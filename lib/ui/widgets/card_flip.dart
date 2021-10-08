import 'dart:math';

import '../../stores/movie_details_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/model/movie.dart';
import 'fade_animation.dart';
import 'grow_transition.dart';

class CardFlip extends StatefulWidget {
  final Movie movie;
  final Widget frontWidget;
  final Widget backWidget;

  const CardFlip({
    this.movie,
    @required this.frontWidget,
    @required this.backWidget,
  });

  @override
  _CardFlipState createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> with TickerProviderStateMixin {
  /// Rotação
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    initializeRotationController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1,
      GestureDetector(
        onTap: onTap,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateX(-pi * _animation.value),
          child: Container(
            child: _animation.value >= 0.5 ? widget.backWidget : widget.frontWidget,
          ),
        ),
      ),
    );
  }

  // Ativada ao tocar no card do filme
  void onTap() {
    GetIt.I<MovieDetailsStore>().changeMovie(widget.movie);
    _animationController.forward();
  }

  // Inicializa os controladores da animação
  void initializeRotationController() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animation.addListener(() => setState(() {}));
    _animation.addStatusListener(onAnimationStatusChanged);
  }

  // Callback para alterações no status da animação
  void onAnimationStatusChanged(status) {
    if (status == AnimationStatus.completed) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          barrierColor: Colors.black.withOpacity(.7),
          maintainState: true,
          opaque: false,
          pageBuilder: (context, a, b) {
            return _TransitionWidget(
              movieId: widget.movie.id,
            );
          },
        ),
      );

      _animationController.reverse();
    }
  }
}

class _TransitionWidget extends StatelessWidget {
  final int movieId;
  const _TransitionWidget({
    Key key,
    this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      alignment: FractionalOffset.center,
      child: Hero(
        tag: movieId,
        child: GrowTransition(
          maxHeight: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
