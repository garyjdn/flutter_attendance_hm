import 'package:flutter/material.dart';

class BackgroundCurveClipper extends CustomClipper<Path> {
  final double offset;

  BackgroundCurveClipper({
    this.offset = 0.0,
  });

  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    // double curve = offset / slow;
    var path = Path();
    path.lineTo(0, height - (85 - offset));
    path.quadraticBezierTo(width / 2, height, width, height - (85 - offset));
    path.lineTo(width, 0);
    path.close();
    print(height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
