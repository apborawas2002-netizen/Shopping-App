import 'package:flutter/material.dart';
import 'package:shopping_app/format.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/theme.dart';
import 'package:shopping_app/widgets/product_photo.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.quantityInCart,
    required this.onAdd,
    required this.onOpen,
  });

  final Product product;
  final int quantityInCart;
  final VoidCallback onAdd;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 168,
              width: double.infinity,
              child: ProductPhoto(product: product),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category.toUpperCase(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        letterSpacing: 1.1,
                        color: marketMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.summary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: marketGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          formatMoney(product.price),
                          style: theme.textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Tooltip(
                          message: 'Add ${product.name}',
                          child: FilledButton(
                            onPressed: onAdd,
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),
                    if (quantityInCart > 0) ...[
                      const SizedBox(height: 6),
                      Text(
                        '$quantityInCart in cart',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: marketGreen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
