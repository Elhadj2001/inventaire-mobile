import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventaire IPD')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.qr_code_scanner, size: 96),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.push('/scan'),
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scanner un bien'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push('/qr-test'),
                icon: const Icon(Icons.qr_code_2),
                label: const Text('Générer un QR de test'),
              ),
              const SizedBox(height: 32),
              Text(
                'API : $apiBaseUrl',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
