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
  MobileScannerController _controller = MobileScannerController();
  PermissionStatus? _permission;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _demanderPermission();
  }

  Future<void> _demanderPermission() async {
    final status = await Permission.camera.request();
    if (mounted) setState(() => _permission = status);
  }

  void _recreerController() {
    _controller.dispose();
    setState(() => _controller = MobileScannerController());
  }

  @override
  void dispose() {
    _controller.dispose();
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
    final permission = _permission;
    Widget corps;
    if (permission == null) {
      corps = const Center(child: CircularProgressIndicator());
    } else if (!permission.isGranted) {
      corps = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.no_photography, size: 64),
              const SizedBox(height: 16),
              const Text(
                "L'accès à la caméra est nécessaire pour scanner les étiquettes QR.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (permission.isPermanentlyDenied)
                FilledButton(
                  onPressed: openAppSettings,
                  child: const Text('Ouvrir les réglages'),
                )
              else
                FilledButton(
                  onPressed: _demanderPermission,
                  child: const Text('Autoriser la caméra'),
                ),
            ],
          ),
        ),
      );
    } else {
      corps = MobileScanner(
        controller: _controller,
        onDetect: _onDetect,
        errorBuilder: (context, error, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur caméra : ${error.errorCode.name}\n'
                    '${error.errorDetails?.message ?? ''}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _recreerController,
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Scanner un QR')),
      body: corps,
    );
  }
}
