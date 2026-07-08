import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // Controller créé seulement une fois la permission caméra accordée
  // (autoStart: false → on démarre nous-mêmes, jamais avant la permission).
  MobileScannerController? _controller;
  PermissionStatus? _permission;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _initialiser();
  }

  Future<void> _initialiser() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    setState(() => _permission = status);
    if (status.isGranted) {
      await _demarrerController();
    }
  }

  Future<void> _demarrerController() async {
    await _controller?.dispose();
    final controller = MobileScannerController(autoStart: false);
    if (!mounted) {
      await controller.dispose();
      return;
    }
    setState(() => _controller = controller);
    try {
      await controller.start();
    } catch (_) {
      // Toute erreur de démarrage est rendue par errorBuilder ci-dessous.
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_navigating) return;
    final code = capture.barcodes
        .map((b) => b.rawValue)
        .whereType<String>()
        .map((v) => v.trim())
        .where((v) => v.isNotEmpty)
        .firstOrNull;
    if (code == null) return;
    _navigating = true;
    context.push('/bien/${Uri.encodeComponent(code)}').then((_) {
      _navigating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner un QR')),
      body: _corps(),
    );
  }

  Widget _corps() {
    final permission = _permission;
    if (permission == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!permission.isGranted) {
      return _MessageCentre(
        icone: Icons.no_photography,
        texte:
            "L'accès à la caméra est nécessaire pour scanner les étiquettes QR.",
        bouton: permission.isPermanentlyDenied
            ? FilledButton(
                onPressed: openAppSettings,
                child: const Text('Ouvrir les réglages'),
              )
            : FilledButton(
                onPressed: _initialiser,
                child: const Text('Autoriser la caméra'),
              ),
      );
    }

    final controller = _controller;
    if (controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MobileScanner(
      controller: controller,
      onDetect: _onDetect,
      errorBuilder: (context, error) {
        final details = error.errorDetails?.message;
        return _MessageCentre(
          icone: Icons.error_outline,
          texte: 'Erreur caméra : ${error.errorCode.name}'
              '${details != null && details.isNotEmpty ? '\n$details' : ''}',
          bouton: FilledButton(
            onPressed: _demarrerController,
            child: const Text('Réessayer'),
          ),
        );
      },
    );
  }
}

class _MessageCentre extends StatelessWidget {
  final IconData icone;
  final String texte;
  final Widget bouton;

  const _MessageCentre({
    required this.icone,
    required this.texte,
    required this.bouton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 64),
            const SizedBox(height: 16),
            Text(texte, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            bouton,
          ],
        ),
      ),
    );
  }
}
