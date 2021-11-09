import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadarConstants {
  static final double padding8 = 16.h; // padding of radar
  static final double heightParams = 32.h; // height of params (angle and distance)
  static final double maxHeightRadius = 600.h - heightParams - padding8; // height of radar
  static final double maxWidthRadius = 850.w; // width of radar
  static final double radius =
      min(maxHeightRadius / 2, maxWidthRadius / 2); // ban kinh
}
