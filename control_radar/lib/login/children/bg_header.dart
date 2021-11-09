import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bgHeaderLogin() {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
        ),
        color: Colors.blue,
      ),
      height: 400.w,
      width: double.infinity
  );
}
