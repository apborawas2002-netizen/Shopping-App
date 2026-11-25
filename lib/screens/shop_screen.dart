import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/product_screen.dart';
import 'package:shopping_app/services/cart_repository.dart';
import 'package:shopping_app/services/catalog_repository.dart';
import 'package:shopping_app/widgets/shop_view.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    super.key,
    required this.catalog,
    required this.cart,
  });

  final CatalogRepository catalog;
  final CartRepository cart;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: catalog.watchProducts(),
      builder: (context, productsSnapshot) {
        return StreamBuilder<List<CartItem>>(
          stream: cart.watchCart(),
          builder: (context, cartSnapshot) {
            final cartItems = cartSnapshot.data ?? const <CartItem>[];
            final quantities = {
              for (final item in cartItems) item.productId: item.quantity,
            };
            final error = productsSnapshot.error ?? cartSnapshot.error;

            return ShopView(
              products: productsSnapshot.data ?? const <Product>[],
              quantities: quantities,
              itemCount: cartCount(cartItems),
              loading: !productsSnapshot.hasData && !productsSnapshot.hasError,
              error: error == null ? null : 'Could not load the shop. $error',
              onAdd: (product) => _add(context, product),
              onOpen: (product) {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => StreamBuilder<List<CartItem>>(
                      stream: cart.watchCart(),
                      builder: (context, snapshot) {
                        final quantity = (snapshot.data ?? const <CartItem>[])
                            .where((item) => item.productId == product.id)
                            .fold<int>(0, (sum, item) => sum + item.quantity);
                        return ProductScreen(
                          product: product,
                          quantityInCart: quantity,
                          onAdd: () => _add(context, product),
                        );
                      },
                    ),
                  ),
                );
              },
              onOpenCart: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => CartScreen(cart: cart),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _add(BuildContext context, Product product) async {
    try {
      await cart.add(product);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('${product.name} added')));
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not add ${product.name}.')),
      );
    }
  }
}
