import 'package:flutter/material.dart';

import 'out_circle_painter.dart';


class OutCircleView extends StatelessWidget {
  final double radius;

  OutCircleView({this.radius});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: OutCirclePainter(radius),
    );
  }
}

