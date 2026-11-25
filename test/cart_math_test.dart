import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/cart_item.dart';

void main() {
  test('cart total multiplies price by quantity', () {
    const items = [
      CartItem(productId: 'mug', name: 'Stoneware mug', price: 18, quantity: 2),
      CartItem(productId: 'lamp', name: 'Brass desk lamp', price: 64, quantity: 1),
    ];

    expect(cartCount(items), 3);
    expect(cartTotal(items), 100);
    expect(items.first.lineTotal, 36);
  });

  test('an empty cart totals zero', () {
    expect(cartTotal(const []), 0);
    expect(cartCount(const []), 0);
  });
}
