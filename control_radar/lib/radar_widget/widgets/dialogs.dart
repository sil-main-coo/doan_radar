import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialog {
  static void showNotifyDialog(
    BuildContext context,
    String mess,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.white,
            elevation: 5,
            title: Text(
              'Lỗi',
              style: Theme.of(context)
                  .primaryTextTheme
                  .title
                  .copyWith(color: Colors.red),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(mess,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .subtitle
                        .copyWith(color: Colors.black)),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                FlatButton(
                    child: Text('OK',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .button
                            .copyWith(color: Colors.white)),
                    color: Colors.blue,
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
          );
        },
        barrierDismissible: false);
  }
}
