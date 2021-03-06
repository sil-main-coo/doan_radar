import 'package:flutter/widgets.dart';

class Utils{
  static Image imageFromBase64String(String base64String) {
    final UriData data = Uri.parse(base64String).data;
    return Image.memory(data.contentAsBytes(),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      fit: BoxFit.cover,
    );
  }
}