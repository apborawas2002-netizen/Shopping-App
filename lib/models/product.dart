class ProductSpec {
  const ProductSpec(this.label, this.value);

  final String label;
  final String value;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.image = '',
    this.details = '',
    this.specifications = const [],
  });

  final String id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String image;
  final String details;
  final List<ProductSpec> specifications;

  String get summary {
    final pack = _spec('Pack');
    final origin = _spec('Origin');
    if (pack != null && origin != null) return '$pack · $origin';
    return pack ?? origin ?? category;
  }

  String? _spec(String label) {
    for (final spec in specifications) {
      if (spec.label == label) return spec.value;
    }
    return null;
  }

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'] as String? ?? 'Item',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      description: data['description'] as String? ?? '',
      category: data['category'] as String? ?? 'Groceries',
      image: data['image'] as String? ?? '',
      details: data['details'] as String? ?? '',
      specifications: _readSpecs(data['specifications']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'details': details,
      'specifications': [
        for (final spec in specifications)
          {'label': spec.label, 'value': spec.value},
      ],
    };
  }
}

List<ProductSpec> _readSpecs(Object? raw) {
  if (raw is! List) return const [];
  return [
    for (final entry in raw)
      if (entry is Map)
        ProductSpec('${entry['label'] ?? ''}', '${entry['value'] ?? ''}'),
  ].where((spec) => spec.label.isNotEmpty).toList();
}
