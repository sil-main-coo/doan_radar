import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadarConstants {
  static final double topPos = 32.h;
  static final double bottomPos = ScreenUtil().screenHeight / 6;
  static final double leftPos = 0;
  static final double rightPos = ScreenUtil().screenWidth /6;

  static final double maxHeightRadius =
      ScreenUtil().screenHeight - (bottomPos + topPos);
  static final double maxWidthRadius =
      ScreenUtil().screenWidth - (leftPos + rightPos);
  static final double radius = min(maxHeightRadius / 2, maxWidthRadius / 2);
}
