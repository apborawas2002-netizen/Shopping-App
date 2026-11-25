import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/product_screen.dart';
import 'package:shopping_app/theme.dart';
import 'package:shopping_app/widgets/cart_view.dart';
import 'package:shopping_app/widgets/shop_view.dart';

void main() {
  testWidgets('adding a product and opening the cart shows the total', (
    tester,
  ) async {
    const mug = Product(
      id: 'mug',
      name: 'Stoneware mug',
      price: 18,
      description: 'Holds a full morning.',
      category: 'Kitchen',
    );
    final added = <Product>[];

    await tester.pumpWidget(
      MaterialApp(
        theme: buildMarketTheme(),
        home: ShopView(
          products: const [mug],
          quantities: const {},
          itemCount: 0,
          onAdd: added.add,
          onOpen: (_) {},
          onOpenCart: () {},
        ),
      ),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pump();

    expect(added, [mug]);
    expect(find.text('Stoneware mug'), findsOneWidget);
    expect(find.text('₹18'), findsOneWidget);
  });

  testWidgets('cart lists items, updates quantity, removes a line, and shows the total', (
    tester,
  ) async {
    final items = [
      const CartItem(
        productId: 'mug',
        name: 'Stoneware mug',
        price: 10,
        quantity: 2,
      ),
      const CartItem(
        productId: 'lamp',
        name: 'Brass desk lamp',
        price: 5,
        quantity: 1,
      ),
    ];
    final quantities = <String, int>{};
    final removed = <String>[];

    await tester.pumpWidget(
      MaterialApp(
        theme: buildMarketTheme(),
        home: CartView(
          items: items,
          onSetQuantity: (item, quantity) => quantities[item.productId] = quantity,
          onRemove: (item) => removed.add(item.productId),
        ),
      ),
    );

    expect(find.text('Stoneware mug'), findsOneWidget);
    expect(find.text('Brass desk lamp'), findsOneWidget);
    expect(find.text('₹20'), findsOneWidget);
    expect(find.text('₹5'), findsWidgets);
    expect(find.byKey(const Key('cart-total')), findsOneWidget);
    expect(find.text('₹25'), findsOneWidget);
    expect(find.text('3 items'), findsOneWidget);

    await tester.tap(find.byTooltip('Increase Stoneware mug'));
    await tester.tap(find.byTooltip('Remove Brass desk lamp'));
    await tester.pump();

    expect(quantities['mug'], 3);
    expect(removed, ['lamp']);
  });

  testWidgets('empty cart shows a zero total', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildMarketTheme(),
        home: CartView(
          items: const [],
          onSetQuantity: (item, quantity) {},
          onRemove: (item) {},
        ),
      ),
    );

    expect(find.text('Your cart is empty'), findsOneWidget);
    expect(find.text('₹0'), findsOneWidget);
    expect(find.text('0 items'), findsOneWidget);
  });

  testWidgets('product page shows the photo details and specifications', (
    tester,
  ) async {
    const dal = Product(
      id: 'toor-dal',
      name: 'Toor dal',
      price: 165,
      description: 'Split pigeon peas for sambar and everyday dal.',
      details: 'Hulled toor dal with a mild, earthy taste.',
      category: 'Staples',
      specifications: [
        ProductSpec('Pack', '1 kg'),
        ProductSpec('Origin', 'Maharashtra'),
      ],
    );

    await tester.binding.setSurfaceSize(const Size(900, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: buildMarketTheme(),
        home: ProductScreen(
          product: dal,
          quantityInCart: 0,
          onAdd: () {},
        ),
      ),
    );

    expect(find.text('Toor dal'), findsWidgets);
    expect(find.text('₹165'), findsOneWidget);
    expect(find.text('Hulled toor dal with a mild, earthy taste.'), findsOneWidget);
    expect(find.text('Specifications'), findsOneWidget);
    expect(find.text('Pack'), findsOneWidget);
    expect(find.text('1 kg'), findsOneWidget);
    expect(find.text('Maharashtra'), findsOneWidget);
    expect(find.text('Add to cart'), findsOneWidget);
  });
}
