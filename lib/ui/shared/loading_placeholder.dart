import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xffe0e0e0),
      period: Duration(milliseconds: 800),
      highlightColor: Color(0xfffafafa),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
