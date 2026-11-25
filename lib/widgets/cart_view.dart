import 'package:flutter/material.dart';
import 'package:shopping_app/format.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/theme.dart';

class CartView extends StatelessWidget {
  const CartView({
    super.key,
    required this.items,
    required this.onSetQuantity,
    required this.onRemove,
    this.loading = false,
    this.error,
  });

  final List<CartItem> items;
  final void Function(CartItem item, int quantity) onSetQuantity;
  final ValueChanged<CartItem> onRemove;
  final bool loading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final total = cartTotal(items);
    final count = cartCount(items);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: _body(context),
        ),
      ),
      bottomNavigationBar: _TotalBar(count: count, total: total),
    );
  }

  Widget _body(BuildContext context) {
    if (error != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(error!),
      );
    }
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (items.isEmpty) {
      return _EmptyCart(onBrowse: () => Navigator.maybePop(context));
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return _CartRow(
          item: item,
          onSetQuantity: onSetQuantity,
          onRemove: onRemove,
        );
      },
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.onBrowse});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_outlined, size: 42, color: marketGreen),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Add a few goods and they will show up here with the total.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton(onPressed: onBrowse, child: const Text('Browse goods')),
        ],
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({
    required this.item,
    required this.onSetQuantity,
    required this.onRemove,
  });

  final CartItem item;
  final void Function(CartItem item, int quantity) onSetQuantity;
  final ValueChanged<CartItem> onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 8, 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${formatMoney(item.price)} each',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 2),
                  child: Text(
                    formatMoney(item.lineTotal),
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  tooltip: 'Decrease ${item.name}',
                  onPressed: () => onSetQuantity(item, item.quantity - 1),
                  icon: const Icon(Icons.remove),
                ),
                Text('${item.quantity}', style: theme.textTheme.titleMedium),
                IconButton(
                  tooltip: 'Increase ${item.name}',
                  onPressed: () => onSetQuantity(item, item.quantity + 1),
                  icon: const Icon(Icons.add),
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Remove ${item.name}',
                  onPressed: () => onRemove(item),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalBar extends StatelessWidget {
  const _TotalBar({required this.count, required this.total});

  final int count;
  final double total;

  @override
  Widget build(BuildContext context) {
    final itemLabel = count == 1 ? '1 item' : '$count items';
    return Material(
      color: marketPaper,
      elevation: 8,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemLabel, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: marketMuted,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                formatMoney(total),
                key: const Key('cart-total'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
