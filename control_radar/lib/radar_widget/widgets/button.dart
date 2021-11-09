import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key key, this.label, this.callback, this.icon})
      : super(key: key);

  final String label;
  final Function callback;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final widget = icon != null
        ? FlatButton.icon(
            onPressed: () => callback(),
            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
            color: Colors.white,
            icon: Icon(icon, size: 24.w,),
            label: Text(
              label.toUpperCase(),
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
          )
        : FlatButton(
            onPressed: () => callback(),
            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
            color: Colors.white,
            child: Text(
              label.toUpperCase(),
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
          );

    return Expanded(
      flex: 1,
      child: SizedBox(
        height: double.infinity,
        child: widget,
      ),
    );
  }
}
