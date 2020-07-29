import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'component.dart';

class ComponentImage implements Component {
  final String id;
  final String title;
  final String type;
  final String image;

  ComponentImage(
      {this.id,
      @required this.title,
      @required this.type,
      @required this.image});

  ComponentImage.fromDocument(DocumentSnapshot snap)
      : id = snap.documentID,
        title = snap.data['title'],
        type = snap.data['type'],
        image = snap.data['image'];

  Map<String, Object> toDocument() => {
        'title': title,
        'type': type,
        'image': image,
      };

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ type.hashCode ^ image.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentImage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          type == other.type &&
          image == other.image;

  @override
  String toString() =>
      'ComponentVideo {id: $id, title: $title, type: $type, image: $image}';
}
