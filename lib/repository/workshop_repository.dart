import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitat_ft_admin/model/workshop_model.dart';


class WorkshopRepository {
  static final WorkshopRepository _workshopRepository =
      WorkshopRepository._internal();

  factory WorkshopRepository() {
    return _workshopRepository;
  }

  WorkshopRepository._internal();

  final _workshopCollection =
      Firestore.instance.collection(Workshop.collectionName);

  Stream<List<Workshop>> all() {
    return _workshopCollection.snapshots().map((snapshot) =>
        snapshot.documents.map((doc) => Workshop.fromDocument(doc)).toList());
  }

  Future<void> add(Workshop workshop) async {
    _workshopCollection.add(workshop.toDocument());
  }

  Future<void> delete(String workshopId) async {
    _workshopCollection.document(workshopId).delete();
  }
}