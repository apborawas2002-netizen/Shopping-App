import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/data/sample_catalog.dart';
import 'package:shopping_app/models/product.dart';

abstract class CatalogRepository {
  Stream<List<Product>> watchProducts();

  Future<void> ensureSeeded();
}

class FirestoreCatalogRepository implements CatalogRepository {
  FirestoreCatalogRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  @override
  Stream<List<Product>> watchProducts() {
    return _products.orderBy('name').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Future<void> ensureSeeded() async {
    final existing = await _products.get();
    final wanted = {for (final product in sampleCatalog) product.id};
    final batch = _firestore.batch();
    for (final product in sampleCatalog) {
      batch.set(_products.doc(product.id), product.toMap());
    }
    for (final doc in existing.docs) {
      if (!wanted.contains(doc.id)) {
        batch.delete(doc.reference);
      }
    }
    await batch.commit();
  }
}
