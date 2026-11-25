import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/theme.dart';

class ProductPhoto extends StatelessWidget {
  const ProductPhoto({
    super.key,
    required this.product,
    this.borderRadius = BorderRadius.zero,
  });

  final Product product;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: const Color(0xFFE7E1D6),
        child: product.image.isEmpty
            ? const Center(
                child: Icon(Icons.shopping_basket_outlined, color: marketGreen, size: 36),
              )
            : Image.asset(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.shopping_basket_outlined, color: marketGreen, size: 36),
                  );
                },
              ),
      ),
    );
  }
}
