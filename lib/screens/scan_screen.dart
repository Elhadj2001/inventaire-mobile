import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../app/theme.dart';
import '../state/scan_validation.dart';
import '../state/session.dart';
import '../state/sync_state.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  MobileScannerController? _controller;
  PermissionStatus? _permission;
  bool _navigating = false;

  final ValidateurScan _validateur = ValidateurScan();
  Set<String> _numerosConnus = {};
  String? _dernierBrut; // dernier code brut détecté (diagnostic)
  EtatLecture? _dernierEtat; // verdict de la dernière lecture (diagnostic)

  @override
  void initState() {
    super.initState();
    _initialiser();
    _chargerNumeros();
  }

  Future<void> _chargerNumeros() async {
    final numeros = await ref.read(appDatabaseProvider).numerosConnus();
    if (mounted) setState(() => _numerosConnus = numeros);
  }

  Future<void> _initialiser() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    setState(() => _permission = status);
    if (status.isGranted) await _demarrerController();
  }

  Future<void> _demarrerController() async {
    await _controller?.dispose();
    final controller = MobileScannerController(
      autoStart: false,
      // Frames en continu : indispensable pour la double lecture (sinon un code
      // n'est signalé qu'une fois et la confirmation n'arrive jamais).
      detectionSpeed: DetectionSpeed.normal,
      // Détection LARGE (tous formats) : restreindre à QR/Code128/Code39 empêchait
      // ML Kit de détecter les étiquettes-caisson réelles (Code 39, symbologie
      // confirmée via design/etiquette_modele.jpeg = « 20437 »). Les codes fantômes
      // (ITF/Codabar sans checksum) sont désormais neutralisés en aval par le
      // filtre de vraisemblance + double lecture + cache (voir _onDetect /
      // ValidateurScan), pas par la liste de formats.
      formats: const [BarcodeFormat.all],
      // Résolution élevée : plus de pixels sur les barres = meilleur décodage 1D.
      cameraResolution: const Size(1920, 1080),
    );
    if (!mounted) {
      await controller.dispose();
      return;
    }
    setState(() => _controller = controller);
    try {
      await controller.start();
    } catch (_) {
      // errorBuilder affichera l'erreur.
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_navigating) return;
    final code = capture.barcodes
        .map((b) => b.rawValue)
        .whereType<String>()
        .map((v) => v.trim())
        .where((v) => v.isNotEmpty)
        .firstOrNull;
    if (code == null) return;

    // Deux barrières anti-fausse-lecture : vraisemblance + double lecture identique.
    final etat = _validateur.traiter(code, _numerosConnus, DateTime.now());
    if (mounted) {
      setState(() {
        _dernierBrut = code;
        _dernierEtat = etat;
      });
    }
    if (etat == EtatLecture.rejetee) {
      return; // lecture ignorée, aucune navigation
    }
    if (etat == EtatLecture.premiere) {
      return; // on attend une deuxième lecture identique avant d'agir
    }

    // etat == confirmee
    _navigating = true;
    await _controller?.stop();
    if (mounted) {
      await context.push('/saisie/${Uri.encodeComponent(code)}');
    }
    // retour automatique au scanner
    _navigating = false;
    _validateur.reinitialiser();
    await _controller?.start();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    if (!session.pretAScanner) {
      // sécurité : sans contexte complet, on ne scanne pas
      return Scaffold(
        appBar: AppBar(title: const Text('Scanner')),
        body: const Center(child: Text('Contexte incomplet. Revenez à l’accueil.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
        actions: [
          if (_controller != null)
            IconButton(
              icon: const Icon(Icons.flash_on),
              onPressed: () => _controller?.toggleTorch(),
            ),
        ],
      ),
      // La caméra dessine edge-to-edge (l'écran scan est exclu du SafeArea global) ;
      // seuls les contrôles du bas sont protégés de la barre de navigation système.
      body: Column(
        children: [
          _Bandeau(session: session),
          Expanded(child: _zoneCamera()),
          SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Diagnostic(
                  brut: _dernierBrut,
                  etat: _dernierEtat,
                  nbConnus: _numerosConnus.length,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/saisie-manuelle'),
                    icon: const Icon(Icons.edit_note),
                    label: const Text('Code illisible ? Saisir manuellement'),
                  ),
                ),
                _DerniersScans(session: session),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _zoneCamera() {
    final permission = _permission;
    if (permission == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!permission.isGranted) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.no_photography, size: 56),
              const SizedBox(height: 12),
              const Text(
                "L'accès à la caméra est nécessaire pour scanner.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: permission.isPermanentlyDenied ? openAppSettings : _initialiser,
                child: Text(permission.isPermanentlyDenied
                    ? 'Ouvrir les réglages'
                    : 'Autoriser la caméra'),
              ),
            ],
          ),
        ),
      );
    }
    final controller = _controller;
    if (controller == null) return const Center(child: CircularProgressIndicator());
    return MobileScanner(
      controller: controller,
      onDetect: _onDetect,
      errorBuilder: (context, error) {
        final details = error.errorDetails?.message;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 56),
                const SizedBox(height: 12),
                Text(
                  'Erreur caméra : ${error.errorCode.name}'
                  '${details != null && details.isNotEmpty ? '\n$details' : ''}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton(onPressed: _demarrerController, child: const Text('Réessayer')),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Diagnostic extends StatelessWidget {
  final String? brut;
  final EtatLecture? etat;
  final int nbConnus;
  const _Diagnostic({required this.brut, required this.etat, required this.nbConnus});

  @override
  Widget build(BuildContext context) {
    final petit = Theme.of(context).textTheme.bodySmall;
    final (String texte, Color couleur, IconData icone) = brut == null
        ? (
            'Aucun code lu pour l’instant — cadrez le code-barres',
            Theme.of(context).colorScheme.onSurfaceVariant,
            Icons.qr_code_scanner,
          )
        : switch (etat) {
            EtatLecture.confirmee => (
                'Détecté : $brut · confirmé',
                IpdCouleurs.vert,
                Icons.check_circle_outline,
              ),
            EtatLecture.premiere => (
                'Détecté : $brut · confirmation…',
                IpdCouleurs.bleu,
                Icons.hourglass_bottom,
              ),
            _ => (
                'Détecté : $brut · rejeté (non plausible)',
                IpdCouleurs.ambre,
                Icons.filter_alt_off_outlined,
              ),
          };
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, size: 16, color: couleur),
          const SizedBox(width: 6),
          Flexible(
            child: Text(texte,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: petit?.copyWith(color: couleur)),
          ),
          const SizedBox(width: 8),
          Text('$nbConnus n° connus', style: petit),
        ],
      ),
    );
  }
}

class _Bandeau extends StatelessWidget {
  final SessionState session;
  const _Bandeau({required this.session});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: scheme.primaryContainer,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${session.lieu!.nom} · ${session.service!.nom}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Chip(
                label: Text('${session.nbScans} scan(s)'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text('${session.piece!.code} — ${session.piece!.libelle}'),
          if (session.responsable.isNotEmpty)
            Text('Responsable : ${session.responsable}',
                style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _DerniersScans extends StatelessWidget {
  final SessionState session;
  const _DerniersScans({required this.session});

  @override
  Widget build(BuildContext context) {
    if (session.recents.isEmpty) return const SizedBox.shrink();
    final heure = DateFormat('HH:mm:ss');
    return SizedBox(
      height: 132,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('Derniers scans de la pièce',
                style: Theme.of(context).textTheme.labelMedium),
          ),
          for (final s in session.recents.take(4))
            ListTile(
              dense: true,
              leading: Icon(s.deja ? Icons.warning_amber_rounded : Icons.check,
                  color: s.deja ? IpdCouleurs.ambre : IpdCouleurs.vert),
              title: Text('${s.numero} — ${s.designation}',
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(
                  '${s.etat.label} · ${heure.format(s.horodatage)}${s.deja ? ' · déjà scanné' : ''}'),
            ),
        ],
      ),
    );
  }
}
