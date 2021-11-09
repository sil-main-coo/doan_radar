import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => SizedBox(
            width: 50.w,
            height: 50.w,
            child: CircularProgressIndicator()));
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}
