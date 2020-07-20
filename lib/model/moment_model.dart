import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class Moment {
  static const String collectionName = 'moments';

  final String id;
  final String title;

  Moment({this.id, @required this.title});

  Moment.fromDocument(DocumentSnapshot snap)
      : id = snap.documentID,
        title = snap.data['title'];

  Map<String, Object> toDocument() => {
        'title': title,
      };

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Moment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  String toString() {
    return 'Moment { id: $id, title: $title }';
  }
}
