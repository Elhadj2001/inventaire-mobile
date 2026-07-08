import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/refs.dart';
import '../services/api.dart';
import '../state/session.dart';

class SaisieScreen extends ConsumerStatefulWidget {
  final String numero;
  const SaisieScreen({super.key, required this.numero});

  @override
  ConsumerState<SaisieScreen> createState() => _SaisieScreenState();
}

class _SaisieScreenState extends ConsumerState<SaisieScreen> {
  final _commentaire = TextEditingController();
  ResolutionBien? _resolution;
  String? _erreurResolution;
  EtatConstate? _etat;
  String? _photoUrl;
  String? _photoLocale;
  bool _envoiEnCours = false;
  bool _uploadEnCours = false;
  bool _forcerInconnu = false;

  @override
  void initState() {
    super.initState();
    _resoudre();
  }

  @override
  void dispose() {
    _commentaire.dispose();
    super.dispose();
  }

  Future<void> _resoudre() async {
    setState(() => _erreurResolution = null);
    try {
      final res = await ref.read(apiProvider).bienParNumero(widget.numero);
      if (mounted) setState(() => _resolution = res);
    } catch (e) {
      if (mounted) setState(() => _erreurResolution = '$e');
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
    setState(() {
      _uploadEnCours = true;
      _photoLocale = fichier.path;
    });
    try {
      final url = await ref.read(apiProvider).uploadPhoto(fichier.path);
      if (mounted) setState(() => _photoUrl = url);
    } on DioException catch (e) {
      if (mounted) {
        final msg = e.response?.statusCode == 503
            ? 'Upload de photos non configuré côté serveur — la photo est ignorée.'
            : 'Échec de l’upload de la photo.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        setState(() => _photoLocale = null);
      }
    } finally {
      if (mounted) setState(() => _uploadEnCours = false);
    }
  }

  Future<void> _envoyer() async {
    final session = ref.read(sessionProvider);
    if (_etat == null || !session.pretAScanner) return;
    setState(() => _envoiEnCours = true);

    final api = ref.read(apiProvider);
    final designation = switch (_resolution) {
      BienTrouve(bien: final b) => b.designation,
      _ => 'À identifier — ${widget.numero}',
    };
    try {
      final resultat = await api.creerLigne(
        id: const Uuid().v4(),
        campagneId: session.campagne!.id,
        // On passe toujours le numéro : le serveur résout un bien connu ou crée
        // un bien « scan_inconnu » (bien_cree=true) dans la même transaction.
        numeroInventaire: widget.numero,
        pieceId: session.piece!.id,
        serviceId: session.service!.id,
        responsable: session.responsable,
        etat: _etat!,
        commentaire: _commentaire.text,
        photoUrl: _photoUrl,
        scanneLe: DateTime.now(),
      );
      ref.read(sessionProvider.notifier).ajouterScan(
            ScanRecent(
              numero: widget.numero,
              designation: designation,
              etat: _etat!,
              horodatage: DateTime.now(),
            ),
          );
      if (mounted) {
        final msg = resultat.dejaEnregistre
            ? 'Déjà enregistré (rejeu ignoré).'
            : resultat.bienCree
                ? 'Enregistré — nouveau bien « à identifier » créé.'
                : 'Scan enregistré.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        context.pop();
      }
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final msg = switch (code) {
        409 => 'Campagne clôturée : enregistrement impossible.',
        422 => 'Incohérence : le service et la pièce ne sont pas du même lieu.',
        _ => 'Échec de l’envoi (${code ?? e.type.name}).',
      };
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    } finally {
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bien ${widget.numero}')),
      body: _corps(),
    );
  }

  Widget _corps() {
    if (_erreurResolution != null) {
      return _centre(Icons.cloud_off, 'Erreur', _erreurResolution!, action: FilledButton(
        onPressed: _resoudre,
        child: const Text('Réessayer'),
      ));
    }
    final res = _resolution;
    if (res == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (res is BienInconnu && !_forcerInconnu) {
      return _centre(
        Icons.help_outline,
        'Bien inconnu',
        'Le code « ${widget.numero} » n’est pas dans le référentiel.',
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
    final inconnu = res is BienInconnu;
    final bien = res is BienTrouve ? res.bien : null;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
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
                  bien?.designation ?? 'Bien non répertorié (sera créé « à identifier »)',
                  style: Theme.of(context).textTheme.titleMedium,
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
        _sectionPhoto(),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: (_etat == null || _envoiEnCours || _uploadEnCours)
              ? null
              : _envoyer,
          icon: _envoiEnCours
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.save),
          label: const Text('Enregistrer le scan'),
        ),
      ],
    );
  }

  Widget _sectionPhoto() {
    return Row(
      children: [
        if (_photoLocale != null)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(_photoLocale!), width: 64, height: 64, fit: BoxFit.cover),
                ),
                if (_uploadEnCours) const CircularProgressIndicator(),
                if (_photoUrl != null)
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.check_circle, color: Colors.green, size: 20),
                  ),
              ],
            ),
          ),
        OutlinedButton.icon(
          onPressed: _uploadEnCours ? null : _choisirPhoto,
          icon: const Icon(Icons.add_a_photo_outlined),
          label: Text(_photoUrl == null ? 'Ajouter une photo' : 'Changer la photo'),
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
