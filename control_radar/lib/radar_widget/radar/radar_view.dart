import 'dart:math';
import 'package:controlradar/radar_widget/widgets/dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:controlradar/bloc/update_data_bloc/bloc.dart';
import 'package:controlradar/radar_widget/radar/radar_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../radar_constants.dart';
import 'out_circle_widget.dart';
import 'point_widget.dart';

class RadarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateDataBloc, UpdateDataState>(
      listener: (context, state) {
        if (state is LoadedData &&
            state.error != null &&
            state.error.isNotEmpty) {
          AppDialog.showNotifyDialog(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is LoadedData) {
          return _buildBody(state);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildBody(LoadedData state) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Color(0xFF444d6a),
            child: Center(
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: OutCircleView(
                    radius: state.radius,
                  ),
                ),
                Transform.rotate(
                  angle: -pi / 2,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: RadarPainter(state.radian, state.radius),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: PointsWidget(
                            points: state.points,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
        Container(
          height: RadarConstants.heightParams,
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _paramText('Góc', '${state.angle}', '°'),
              _paramText('Cự ly', '${state.currentDistance}', 'cm')
            ],
          ),
        ),
      ],
    );
  }

  Widget _paramText(String label, String value, String unit) {
    return Text(
      '$label: $value$unit',
      style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
    );
  }
}
