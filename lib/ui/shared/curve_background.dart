import 'package:flutter/material.dart';

import 'clipper/curve_background_clipper.dart';

class CurveBackground extends StatelessWidget {
  const CurveBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundCurveClipper(offset: 0),
      child: Container(
        height: 375.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
