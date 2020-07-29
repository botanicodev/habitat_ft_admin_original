import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'component.dart';

class ComponentDocument implements Component {
  final String id;
  final String title;
  final String type;
  final String document;

  ComponentDocument(
      {this.id,
      @required this.title,
      @required this.type,
      @required this.document});

  ComponentDocument.fromDocument(DocumentSnapshot snap)
      : id = snap.documentID,
        title = snap.data['title'],
        type = snap.data['type'],
        document = snap.data['document'];

  Map<String, Object> toDocument() => {
        'title': title,
        'type': type,
        'document': document,
      };

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ type.hashCode ^ document.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentDocument &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          type == other.type &&
          document == other.document;

  @override
  String toString() =>
      'ComponentDocument {id: $id, title: $title, type: $type, document: $document}';
}
