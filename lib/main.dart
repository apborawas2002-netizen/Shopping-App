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

  @overrides
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field & Co.',
      debugShowCheckedModeBanner: false,
      theme: buildMarketTheme(),
      home: firebaseReady ? const ShopBootstrap() : const SetupScreen(),
    );
  }
}
