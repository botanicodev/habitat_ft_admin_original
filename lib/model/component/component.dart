import 'package:cloud_firestore/cloud_firestore.dart';

import 'component_document_model.dart';
import 'component_image_model.dart';
import 'component_type.dart';
import 'component_video_model.dart';



abstract class Component {

  final String id;
  final String title;
  final String type;

  static const String collectionName = 'components';

  Component(this.id, this.title, this.type);

  static Component fromDocument(DocumentSnapshot doc) {
    if (ComponentType.video == doc.data['type']) {
      return ComponentVideo.fromDocument(doc);
    } else if (ComponentType.document == doc.data['type']) {
      return ComponentDocument.fromDocument(doc);
    } else if (ComponentType.image == doc.data['type']) {
      return ComponentImage.fromDocument(doc);
    } else {
      return ComponentVideo.fromDocument(doc);
    }
  }

  static Map<String, Object> toDocument(Component component) {
    if (component is ComponentVideo) {
      return component.toDocument();
    } else if (component is ComponentDocument){
      return component.toDocument();
    } else if (component is ComponentImage) {
      return component.toDocument();
    } else {
      return null;
    }
  }
}
