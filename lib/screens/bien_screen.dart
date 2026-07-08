import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/bien.dart';
import '../services/api.dart';

class BienScreen extends ConsumerWidget {
  final String numero;

  const BienScreen({super.key, required this.numero});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolution = ref.watch(bienParNumeroProvider(numero));

    return Scaffold(
      appBar: AppBar(title: const Text('Fiche du bien')),
      body: resolution.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _Message(
          icone: Icons.cloud_off,
          titre: 'Erreur de connexion à l’API',
          detail: '$e',
          action: FilledButton(
            onPressed: () => ref.invalidate(bienParNumeroProvider(numero)),
            child: const Text('Réessayer'),
          ),
        ),
        data: (res) => switch (res) {
          BienInconnu(numeroScanne: final code) => _Message(
              icone: Icons.help_outline,
              titre: 'Bien inconnu',
              detail:
                  'Le code scanné « $code » ne correspond à aucun bien du référentiel (10 092 biens).',
            ),
          BienTrouve(bien: final bien) => _FicheBien(bien: bien),
        },
      ),
    );
  }
}

class _FicheBien extends StatelessWidget {
  final Bien bien;

  const _FicheBien({required this.bien});

  @override
  Widget build(BuildContext context) {
    final piece = bien.piece;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('N° ${bien.numeroInventaire}',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(bien.designation,
                    style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.verified_outlined),
          title: const Text('Statut'),
          subtitle: Text(bien.statut),
        ),
        ListTile(
          leading: const Icon(Icons.health_and_safety_outlined),
          title: const Text('État'),
          subtitle: Text(bien.etat ?? 'Inconnu (aucun inventaire encore)'),
        ),
        ListTile(
          leading: const Icon(Icons.place_outlined),
          title: const Text('Pièce théorique'),
          subtitle: piece == null
              ? const Text('Non renseignée (sera établie à la 1re campagne)')
              : Text(
                  '${piece.code}\n${piece.libelle}\n'
                  'Site ${piece.lieu.code} — ${piece.lieu.nom}'
                  '${piece.batiment != null ? ' · Bât. ${piece.batiment}' : ''}'
                  '${piece.niveau != null ? ' · Niveau ${piece.niveau}' : ''}',
                ),
        ),
        ListTile(
          leading: const Icon(Icons.source_outlined),
          title: const Text('Source'),
          subtitle: Text(bien.source),
        ),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  final IconData icone;
  final String titre;
  final String detail;
  final Widget? action;

  const _Message({
    required this.icone,
    required this.titre,
    required this.detail,
    this.action,
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
            Text(titre, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(detail, textAlign: TextAlign.center),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
