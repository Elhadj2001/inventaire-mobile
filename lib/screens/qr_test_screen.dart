import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Génère un QR à partir d'un n° d'inventaire (ex. 10001) pour tester le flux
/// scan → API → fiche avec un second appareil ou une étiquette imprimée.
class QrTestScreen extends StatefulWidget {
  const QrTestScreen({super.key});

  @override
  State<QrTestScreen> createState() => _QrTestScreenState();
}

class _QrTestScreenState extends State<QrTestScreen> {
  final _controller = TextEditingController(text: '10001');
  String _donnee = '10001';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR de test')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "N° d'inventaire",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (v) => setState(() => _donnee = v.trim()),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => setState(() => _donnee = _controller.text.trim()),
              child: const Text('Générer'),
            ),
            const SizedBox(height: 24),
            if (_donnee.isNotEmpty)
              Expanded(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: QrImageView(data: _donnee, size: 240),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
