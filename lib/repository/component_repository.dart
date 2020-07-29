import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitat_ft_admin/model/component/component.dart';
import 'package:habitat_ft_admin/model/moment_model.dart';
import 'package:habitat_ft_admin/model/workshop_model.dart';

class ComponentRepository {
  CollectionReference _componentReference;

  ComponentRepository(String workshopId, String momentId) {
    this._componentReference = Firestore.instance
        .collection(Workshop.collectionName)
        .document(workshopId)
        .collection(Moment.collectionName)
        .document(momentId)
        .collection(Component.collectionName);
  }

  Stream<List<Component>> all() {
    return _componentReference.snapshots().map((snapshot) =>
        snapshot.documents.map((doc) => Component.fromDocument(doc)).toList());
  }

  Future<void> add(Component component) async {
    _componentReference.add(Component.toDocument(component));
  }

  Future<void> delete(String componentId) async {
    _componentReference.document(componentId).delete();
  }
}
