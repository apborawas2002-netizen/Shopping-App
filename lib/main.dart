import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/bootstrap.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/screens/setup_screen.dart';
import 'package:shopping_app/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseReady = FirebaseConfig.useEmulator || FirebaseConfig.isConfigured;
  if (firebaseReady) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (FirebaseConfig.useEmulator) { // Use emulator for development
      final host = firebaseEmulatorHost();
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
      await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    }
  }
  runApp(ShoppingApp(firebaseReady: firebaseReady));
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key, required this.firebaseReady});

  final bool firebaseReady;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field & Co.',
      debugShowCheckedModeBanner: false,
      theme: buildMarketTheme(),
      builder: (context, child) {
        return ColoredBox(
          color: marketCream,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: child ?? const SizedBox.shrink()),
              const _DeveloperMark(),
            ],
          ),
        );
      },
      home: firebaseReady ? const ShopBootstrap() : const SetupScreen(),
    );
  }
}

class _DeveloperMark extends StatelessWidget {
  const _DeveloperMark();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: marketCream,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
          child: Text(
            'Developed by Anil Kumar',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: marketMuted.withValues(alpha: 0.9),
              letterSpacing: 0.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
