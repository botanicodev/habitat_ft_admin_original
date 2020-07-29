import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'component.dart';


class ComponentVideo implements Component {
  final String id;
  final String title;
  final String type;
  final String link;

  ComponentVideo(
      {this.id,
      @required this.title,
      @required this.type,
      @required this.link});

  ComponentVideo.fromDocument(DocumentSnapshot snap)
      : id = snap.documentID,
        title = snap.data['title'],
        type = snap.data['type'],
        link = snap.data['link'];


  Map<String, Object> toDocument() =>
    {
      'title': title,
      'type': type,
      'link': link,
    };
  

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ type.hashCode ^ link.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentVideo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          type == other.type &&
          link == other.link;

  @override
  String toString() => 'ComponentVideo {id: $id, title: $title, type: $type, link: $link}';


}
