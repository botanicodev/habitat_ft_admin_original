import 'package:flutter/material.dart';

class ComponentType {
  static final String video = 'video';
  static final String document = 'document';
  static final String image = 'image';

  static Icon iconVideo({double size = 30}) =>
      Icon(Icons.videocam, color: Colors.red, size: size);
  static Icon icondocument({double size = 30}) =>
      Icon(Icons.description, color: Colors.pinkAccent, size: size);
  static Icon iconImage({double size = 30}) =>
      Icon(Icons.image, color: Colors.purpleAccent, size: size);

  static Icon getIconByType(String type) {
    switch (type) {
      case 'video':
        return iconVideo();
        break;
      case 'document':
        return icondocument();
        break;
      case 'image':
        return iconImage();
        break;
      default:
        return Icon(Icons.not_interested);
    }
  }
}
