import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../app/theme.dart';
import '../data/database.dart';
import '../models/refs.dart';
import '../state/session.dart';
import '../state/sync_state.dart';

class SaisieScreen extends ConsumerStatefulWidget {
  final String numero;
  final bool manuelle; // saisie manuelle (code illisible) : photo obligatoire
  const SaisieScreen({super.key, required this.numero, this.manuelle = false});

  @override
  ConsumerState<SaisieScreen> createState() => _SaisieScreenState();
}

class _SaisieScreenState extends ConsumerState<SaisieScreen> {
  final _commentaire = TextEditingController();
  BiensCacheData? _bien;
  bool _resolu = false;
  EtatConstate? _etat;
  String? _photoLocale;
  bool _envoiEnCours = false;
  bool _forcerInconnu = false;
  DejaScanne? _deja;

  @override
  void initState() {
    super.initState();
    _resoudreLocal();
  }

  @override
  void dispose() {
    _commentaire.dispose();
    super.dispose();
  }

  /// Résolution locale (cache) + vérification instantanée « déjà scanné ».
  Future<void> _resoudreLocal() async {
    final db = ref.read(appDatabaseProvider);
    final bien = await db.bienParNumero(widget.numero);
    final campagne = ref.read(sessionProvider).campagne;
    final deja = campagne == null ? null : await db.dejaScanne(campagne.id, widget.numero);
    if (mounted) {
      setState(() {
        _bien = bien;
        _deja = deja;
        _resolu = true;
      });
    }
  }

  Future<void> _choisirPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Appareil photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galerie'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    final fichier = await ImagePicker().pickImage(source: source, imageQuality: 70, maxWidth: 1600);
    if (fichier == null) return;
    // La photo est conservée localement ; l'upload se fait à la synchro (offline-first).
    setState(() => _photoLocale = fichier.path);
  }

  Future<void> _enregistrer() async {
    final session = ref.read(sessionProvider);
    if (_etat == null || !session.pretAScanner) return;

    // Alerte « déjà scanné » : plusieurs scans restent autorisés, mais on avertit.
    if (_deja != null && !await _confirmerDoublon()) return;

    setState(() => _envoiEnCours = true);

    final db = ref.read(appDatabaseProvider);
    final service = session.service!;
    // Le service choisi est-il provisoire (créé offline) ?
    final provisoire = await db.serviceProvisoire(service.id);

    final designation = _bien?.designation ?? 'À identifier — ${widget.numero}';
    await db.enfilerScan(ScansLocauxCompanion.insert(
      id: const Uuid().v4(),
      campagneId: session.campagne!.id,
      numeroInventaire: widget.numero,
      pieceId: session.piece!.id,
      serviceId: Value(provisoire == null ? service.id : provisoire.serverId),
      serviceLocalId: Value(provisoire == null ? null : service.id),
      responsable: Value(session.responsable.isEmpty ? null : session.responsable),
      etat: _etat!.api,
      commentaire: Value(_commentaire.text.isEmpty ? null : _commentaire.text),
      photoLocale: Value(_photoLocale),
      scanneLe: DateTime.now(), // heure de l'appareil au moment du scan
      creeLe: DateTime.now(),
      saisieManuelle: Value(widget.manuelle),
    ));

    ref.read(sessionProvider.notifier).ajouterScan(ScanRecent(
          numero: widget.numero,
          designation: designation,
          etat: _etat!,
          horodatage: DateTime.now(),
          deja: _deja != null,
        ));
    // Déclenche la synchro en arrière-plan (sans bloquer le retour au scanner).
    unawaited(ref.read(syncControllerProvider.notifier).synchroniser());

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scan enregistré (en file de synchronisation).')),
      );
      context.pop();
    }
  }

  String _messageDeja() {
    final d = _deja!;
    final quand = DateFormat('dd/MM à HH:mm').format(d.scanneLe.toLocal());
    final ou = d.pieceCode.isEmpty ? '' : ' dans ${d.pieceCode}';
    return 'Déjà scanné dans cette campagne — le $quand par ${d.par}$ou';
  }

  Future<bool> _confirmerDoublon() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, color: IpdCouleurs.ambre, size: 40),
        title: const Text('Déjà scanné'),
        content: Text('${_messageDeja()}.\n\nEnregistrer quand même un nouveau scan ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Enregistrer quand même')),
        ],
      ),
    );
    return ok ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bien ${widget.numero}')),
      body: _corps(),
    );
  }

  Widget _corps() {
    if (!_resolu) return const Center(child: CircularProgressIndicator());

    final inconnu = _bien == null;
    if (inconnu && !_forcerInconnu) {
      return _centre(
        Icons.help_outline,
        'Bien inconnu du cache',
        'Le code « ${widget.numero} » n’est pas dans le référentiel local. '
            'Vous pouvez tout de même l’enregistrer (il sera créé « à identifier »).',
        action: Column(
          children: [
            FilledButton(
              onPressed: () => setState(() => _forcerInconnu = true),
              child: const Text('Enregistrer quand même'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: () => context.pop(), child: const Text('Ignorer')),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_deja != null)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: IpdCouleurs.ambreTint,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF0DCAE)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: IpdCouleurs.ambreFonce),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('⚠ ${_messageDeja()}',
                      style: const TextStyle(color: IpdCouleurs.ambreFonce, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        Card(
          color: inconnu ? Theme.of(context).colorScheme.errorContainer : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('N° ${widget.numero}', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Text(
                  _bien?.designation ?? 'Bien non répertorié (sera créé « à identifier »)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (_bien != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('Statut (cache) : ${_bien!.statut}',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('État constaté *', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (final e in EtatConstate.values)
              ChoiceChip(
                label: Text(e.label),
                selected: _etat == e,
                onSelected: (_) => setState(() => _etat = e),
              ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _commentaire,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Commentaire (optionnel)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            if (_photoLocale != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(_photoLocale!), width: 64, height: 64, fit: BoxFit.cover),
                ),
              ),
            OutlinedButton.icon(
              onPressed: _choisirPhoto,
              icon: const Icon(Icons.add_a_photo_outlined),
              label: Text(_photoLocale == null
                  ? (widget.manuelle ? 'Photo obligatoire *' : 'Ajouter une photo')
                  : 'Changer la photo'),
            ),
          ],
        ),
        if (widget.manuelle && _photoLocale == null)
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text('Saisie manuelle : la photo (étiquette/bien) est obligatoire.',
                style: TextStyle(color: IpdCouleurs.ambreFonce, fontSize: 12)),
          ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: (_etat == null || _envoiEnCours || (widget.manuelle && _photoLocale == null))
              ? null
              : _enregistrer,
          icon: _envoiEnCours
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.save),
          label: Text(widget.manuelle ? 'Enregistrer (saisie manuelle)' : 'Enregistrer le scan'),
        ),
      ],
    );
  }

  Widget _centre(IconData icone, String titre, String detail, {Widget? action}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 56),
            const SizedBox(height: 12),
            Text(titre, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(detail, textAlign: TextAlign.center),
            if (action != null) ...[const SizedBox(height: 16), action],
          ],
        ),
      ),
    );
  }
}
