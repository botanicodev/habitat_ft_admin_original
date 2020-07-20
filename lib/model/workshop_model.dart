import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class Workshop {
  static const String collectionName = 'workshops';

  final String id;
  final String title;
  final String description;

  Workshop({this.id, @required this.title, @required this.description});

  Workshop.fromDocument(DocumentSnapshot snap)
      : id = snap.documentID,
        title = snap.data['title'],
        description = snap['description'];

  Map<String, Object> toDocument() => {
        'title': title,
        'description': description,
      };

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workshop &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description;

  @override
  String toString() {
    return 'Workshop { id: $id, title: $title, description: $description }';
  }
}