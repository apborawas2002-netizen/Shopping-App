import 'package:flutter/material.dart';
import 'package:shopping_app/format.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/theme.dart';
import 'package:shopping_app/widgets/product_photo.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.product,
    required this.quantityInCart,
    required this.onAdd,
  });

  final Product product;
  final int quantityInCart;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              AspectRatio(
                aspectRatio: 1.15,
                child: ProductPhoto(
                  product: product,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                product.category.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.1,
                  color: marketMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(product.name, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(formatMoney(product.price), style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(
                product.details.isEmpty ? product.description : product.details,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 22),
              Text('Specifications', style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              Card(
                child: Column(
                  children: [
                    for (var i = 0; i < product.specifications.length; i++)
                      _SpecRow(
                        spec: product.specifications[i],
                        shaded: i.isOdd,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: onAdd,
                child: Text(
                  quantityInCart > 0
                      ? 'Add another · $quantityInCart in cart'
                      : 'Add to cart',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  const _SpecRow({required this.spec, required this.shaded});

  final ProductSpec spec;
  final bool shaded;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: shaded ? const Color(0xFFF7F3EC) : marketPaper,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                spec.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: marketMuted,
                ),
              ),
            ),
            Expanded(
              child: Text(
                spec.value,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
