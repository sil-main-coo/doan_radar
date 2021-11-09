import 'package:controlradar/constants/utils.dart';
import 'package:controlradar/get_it.dart';
import 'package:controlradar/providers/firebase/firebase_helper.dart';
import 'package:controlradar/radar_widget/map/map_screen.dart';
import 'package:controlradar/radar_widget/photo_view/hero_photo_view_screen.dart';
import 'package:controlradar/radar_widget/widgets/button.dart';
import 'package:controlradar/radar_widget/widgets/dialogs.dart';
import 'package:controlradar/radar_widget/widgets/loading_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayPictureWidget extends StatelessWidget {
  const DisplayPictureWidget({Key key}) : super(key: key);

  Future takePicture(BuildContext context) async {
    LoadingDialog.show(context);
    try {
      await locator.get<FirebaseDatabaseHelper>().turnOnCamera();
      LoadingDialog.hide(context);
    } catch (e) {
      LoadingDialog.hide(context);
      AppDialog.showNotifyDialog(context, 'Lỗi khi gửi lệnh chụp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Color(0xFF444d6a),
      child: Column(
        children: [
          _imageBuilder(),
          SizedBox(
            height: 16.h,
          ),
          Container(
            height: 72.h,
            child: Row(
              children: [
                _locationButton(context),
                SizedBox(
                  width: 8.w,
                ),
                AppButton(
                    label: "Chụp",
                    icon: Icons.camera_alt,
                    callback: () async => await takePicture(context)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageBuilder() {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: StreamBuilder<Event>(
          stream: locator
              .get<FirebaseDatabaseHelper>()
              .appMessagesRef
              .child('anh')
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.snapshot.value != null) {
              final img =
                  Utils.imageFromBase64String(snapshot.data.snapshot.value);

              return InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HeroPhotoViewRouteWrapper(imageProvider: img.image
                                  // tag: tagImage,
                                  ),
                        ),
                      ),
                  child: img);
            }

            return SizedBox(
                height: 50.w,
                width: 50.w,
                child: Center(
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ));
          }),
    ));
  }

  Widget _locationButton(BuildContext context) {
    return AppButton(
        label: "Định vị",
        icon: Icons.gps_fixed,
        callback: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => MapScreen())));
  }
}
