class CartItem {
  const CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  final String productId;
  final String name;
  final double price;
  final int quantity;

  double get lineTotal => price * quantity;

  factory CartItem.fromMap(String id, Map<String, dynamic> data) {
    return CartItem(
      productId: id,
      name: data['name'] as String? ?? 'Item',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      quantity: (data['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}

double cartTotal(Iterable<CartItem> items) {
  return items.fold(0, (sum, item) => sum + item.lineTotal);
}

int cartCount(Iterable<CartItem> items) {
  return items.fold(0, (sum, item) => sum + item.quantity);
}
