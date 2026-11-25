import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/theme.dart';
import 'package:shopping_app/widgets/product_card.dart';

class ShopView extends StatelessWidget {
  const ShopView({
    super.key,
    required this.products,
    required this.quantities,
    required this.itemCount,
    required this.onAdd,
    required this.onOpen,
    required this.onOpenCart,
    this.loading = false,
    this.error,
  });

  final List<Product> products;
  final Map<String, int> quantities;
  final int itemCount;
  final ValueChanged<Product> onAdd;
  final ValueChanged<Product> onOpen;
  final VoidCallback onOpenCart;
  final bool loading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field & Co.'),
        actions: [
          IconButton(
            tooltip: 'Open cart',
            onPressed: onOpenCart,
            icon: Badge(
              isLabelVisible: itemCount > 0,
              label: Text('$itemCount'),
              backgroundColor: marketGreen,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = _columnsFor(constraints.maxWidth);
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                children: [
                  Text(
                    'Indian groceries',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap an item for the photo, details, and specifications. Add it to see the total in the cart.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  if (error != null)
                    _Notice(message: error!)
                  else if (loading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (products.isEmpty)
                    const _Notice(
                      message: 'The catalog is empty right now.',
                    )
                  else
                    _ProductGrid(
                      columns: columns,
                      products: products,
                      quantities: quantities,
                      onAdd: onAdd,
                      onOpen: onOpen,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.columns,
    required this.products,
    required this.quantities,
    required this.onAdd,
    required this.onOpen,
  });

  final int columns;
  final List<Product> products;
  final Map<String, int> quantities;
  final ValueChanged<Product> onAdd;
  final ValueChanged<Product> onOpen;

  @override
  Widget build(BuildContext context) {
    if (columns == 1) {
      return Column(
        children: [
          for (final product in products) ...[
            SizedBox(
              height: 430,
              child: ProductCard(
                product: product,
                quantityInCart: quantities[product.id] ?? 0,
                onAdd: () => onAdd(product),
                onOpen: () => onOpen(product),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 430,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          quantityInCart: quantities[product.id] ?? 0,
          onAdd: () => onAdd(product),
          onOpen: () => onOpen(product),
        );
      },
    );
  }
}

int _columnsFor(double width) {
  if (width >= 1000) return 3;
  if (width >= 680) return 2;
  return 1;
}

class _Notice extends StatelessWidget {
  const _Notice({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: marketPaper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6DFD4)),
      ),
      child: Text(message),
    );
  }
}
