import 'package:flutter/material.dart';
import 'package:shopping_app/theme.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
            children: [
              Text(
                'Field & Co.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Connect a Firebase project so the catalog and each cart can be saved.',
              ),
              const SizedBox(height: 24),
              const _Step(
                number: '1',
                text:
                    'Create a Firebase project and turn on Authentication → Anonymous.',
              ),
              const _Step(
                number: '2',
                text: 'Create a Cloud Firestore database.',
              ),
              const _Step(
                number: '3',
                text:
                    'Register a Web app and an Android app. Use the package name com.shoppingapp.shopping_app.',
              ),
              const _Step(
                number: '4',
                text:
                    'Paste the API keys and app ids into lib/firebase_options.dart, replacing every YOUR_ value.',
              ),
              const _Step(
                number: '5',
                text:
                    'Publish firestore.rules from this project in the Firebase console, under Firestore → Rules.',
              ),
              const SizedBox(height: 8),
              const Text(
                'Then run the app on Chrome or an Android device. The first launch writes the sample catalog, and each visitor gets a private cart through anonymous sign-in.',
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: marketPaper,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE6DFD4)),
                ),
                child: const Text(
                  'Local emulators: start the Auth and Firestore emulators for project demo-field-co, then run\n\nflutter run -d chrome --dart-define=USE_FIREBASE_EMULATOR=true',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: marketGreen,
            foregroundColor: Colors.white,
            child: Text(
              number,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
