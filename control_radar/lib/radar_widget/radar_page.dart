import 'package:flutter/material.dart';
import 'control/control_radar_widget.dart';
import 'picture/display_picture_widget.dart';
import 'radar/radar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600.h,
          child: Row(
            children: [
              SizedBox(width: 850.w, child: RadarView()),
              Flexible(flex: 1, child: DisplayPictureWidget()),
            ],
          ),
        ),
        ControlRadarWidget(),
      ],
    );
  }
}
