import 'package:flutter/widgets.dart';

typedef ScreenSizeWidgetBuilder = Widget Function(BuildContext context, _SizeConfig _sizeConfig);

class SizeConfigWidget extends StatelessWidget {
  final ScreenSizeWidgetBuilder builder;

  const SizeConfigWidget({
    @required this.builder,
  }) : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    final _SizeConfig config = _SizeConfig(context);
    return builder(context, config);
  }
}

class _SizeConfig {
  MediaQueryData _mediaQueryData;
  double _safeAreaHorizontal;
  double _safeAreaVertical;

  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;
  double safeBlockHorizontal;
  double safeBlockVertical;

  _SizeConfig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
