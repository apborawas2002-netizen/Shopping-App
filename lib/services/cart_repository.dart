import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/models/product.dart';

abstract class CartRepository {
  Stream<List<CartItem>> watchCart();

  Future<void> add(Product product);

  Future<void> setQuantity(String productId, int quantity);

  Future<void> remove(String productId);
}

class FirestoreCartRepository implements CartRepository {
  FirestoreCartRepository(this._firestore, this.userId);

  final FirebaseFirestore _firestore;
  final String userId;

  CollectionReference<Map<String, dynamic>> get _items => _firestore
      .collection('carts')
      .doc(userId)
      .collection('items');

  @override
  Stream<List<CartItem>> watchCart() {
    return _items.orderBy('name').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CartItem.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Future<void> add(Product product) async {
    final ref = _items.doc(product.id);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      if (!snapshot.exists) {
        transaction.set(ref, {
          'name': product.name,
          'price': product.price,
          'quantity': 1,
        });
        return;
      }
      final current = (snapshot.data()?['quantity'] as num?)?.toInt() ?? 0;
      transaction.update(ref, {'quantity': current + 1});
    });
  }

  @override
  Future<void> setQuantity(String productId, int quantity) async {
    final ref = _items.doc(productId);
    if (quantity <= 0) {
      await ref.delete();
      return;
    }
    await ref.update({'quantity': quantity});
  }

  @override
  Future<void> remove(String productId) {
    return _items.doc(productId).delete();
  }
}
