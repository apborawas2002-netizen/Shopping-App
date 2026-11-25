import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/shop_screen.dart';
import 'package:shopping_app/services/cart_repository.dart';
import 'package:shopping_app/services/catalog_repository.dart';
import 'package:shopping_app/theme.dart';

class ShopBootstrap extends StatefulWidget {
  const ShopBootstrap({super.key});

  @override
  State<ShopBootstrap> createState() => _ShopBootstrapState();
}

class _ShopBootstrapState extends State<ShopBootstrap> {
  late Future<_Session> _session;

  @override
  void initState() {
    super.initState();
    _session = _open();
  }

  Future<_Session> _open() async {
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser ?? (await auth.signInAnonymously()).user;
      if (user == null) {
        throw ShopBootException('Firebase Auth did not return a user.');
      }
      final catalog = FirestoreCatalogRepository(FirebaseFirestore.instance);
      await catalog.ensureSeeded();
      final cart = FirestoreCartRepository(FirebaseFirestore.instance, user.uid);
      return _Session(catalog: catalog, cart: cart);
    } catch (error) {
      throw ShopBootException(friendlyFirebaseMessage(error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_Session>(
      future: _session,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _OpeningShop();
        }
        if (snapshot.hasError || snapshot.data == null) {
          return _BootError(
            message: '${snapshot.error}',
            onRetry: () => setState(() => _session = _open()),
          );
        }
        final session = snapshot.data!;
        return ShopScreen(catalog: session.catalog, cart: session.cart);
      },
    );
  }
}

class _Session {
  const _Session({required this.catalog, required this.cart});

  final CatalogRepository catalog;
  final CartRepository cart;
}

class ShopBootException implements Exception {
  ShopBootException(this.message);

  final String message;

  @override
  String toString() => message;
}

String friendlyFirebaseMessage(Object error) {
  final text = error.toString();
  if (error is ShopBootException) return error.message;
  if (text.contains('operation-not-allowed') ||
      text.contains('admin-restricted-operation')) {
    return 'Anonymous sign-in is off. In the Firebase console, open Authentication → Sign-in method and enable Anonymous.';
  }
  if (text.contains('permission-denied') || text.contains('PERMISSION_DENIED')) {
    return 'Firestore refused the grocery catalog. Publish the latest firestore.rules so items, photos, and specifications can be saved.';
  }
  if (text.contains('unavailable') ||
      text.contains('network-request-failed') ||
      text.contains('Failed host lookup')) {
    return 'The app could not reach Firebase. Check the keys in lib/firebase_options.dart and the network connection.';
  }
  return text;
}

class _OpeningShop extends StatelessWidget {
  const _OpeningShop();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Opening the shop'),
          ],
        ),
      ),
    );
  }
}

class _BootError extends StatelessWidget {
  const _BootError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off, color: marketGreen, size: 36),
                const SizedBox(height: 16),
                Text(
                  'Firebase is not ready',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                FilledButton(onPressed: onRetry, child: const Text('Try again')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
