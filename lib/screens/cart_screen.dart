import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/services/cart_repository.dart';
import 'package:shopping_app/widgets/cart_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cart});

  final CartRepository cart;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CartItem>>(
      stream: cart.watchCart(),
      builder: (context, snapshot) {
        return CartView(
          items: snapshot.data ?? const <CartItem>[],
          loading: !snapshot.hasData && !snapshot.hasError,
          error: snapshot.hasError ? 'Could not load the cart. ${snapshot.error}' : null,
          onSetQuantity: (item, quantity) => _setQuantity(context, item, quantity),
          onRemove: (item) => _remove(context, item),
        );
      },
    );
  }

  Future<void> _setQuantity(
    BuildContext context,
    CartItem item,
    int quantity,
  ) async {
    try {
      await cart.setQuantity(item.productId, quantity);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update ${item.name}.')),
      );
    }
  }

  Future<void> _remove(BuildContext context, CartItem item) async {
    try {
      await cart.remove(item.productId);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not remove ${item.name}.')),
      );
    }
  }
}
