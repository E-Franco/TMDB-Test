import 'package:flutter/material.dart';

import '../screens/movie_details/movie_details_screen.dart';

class GrowTransition extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;
  const GrowTransition({Key key, this.maxHeight, this.maxWidth}) : super(key: key);

  @override
  _GrowTransitionState createState() => _GrowTransitionState();
}

class _GrowTransitionState extends State<GrowTransition> with TickerProviderStateMixin {
  /// Tamanho
  AnimationController _sizeController;
  Animation _sizeAnimation;

  @override
  void initState() {
    super.initState();
    initializeSizeController();
  }

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          width: _sizeAnimation.value,
          height: _sizeAnimation.value + 100,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  // Inicializa controladores da animação
  void initializeSizeController() async {
    _sizeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _sizeAnimation = Tween<double>(begin: 250, end: widget.maxHeight).animate(_sizeController);
    _sizeAnimation.addListener(() => setState(() {}));
    _sizeController.addStatusListener(onAnimationStatusChanged);

    // Ativa a animação
    expand();
  }

  // Responsável pro acionar o controlador
  void expand() {
    _sizeController.forward();
  }

  // Callback para alterações no status da animação
  void onAnimationStatusChanged(status) {
    if (status == AnimationStatus.completed) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a, b) {
            return MovieDetailsScreen();
          },
        ),
      );
    }
  }
}
