import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/auth.dart';
import '../state/session.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campagneAsync = ref.watch(campagneOuverteProvider);
    final session = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaire IPD'),
        actions: [
          IconButton(
            tooltip: 'Déconnexion',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(campagneOuverteProvider),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            campagneAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => _Carte(
                icone: Icons.cloud_off,
                titre: 'Erreur de connexion',
                sousTitre: '$e',
                action: FilledButton(
                  onPressed: () => ref.invalidate(campagneOuverteProvider),
                  child: const Text('Réessayer'),
                ),
              ),
              data: (campagne) {
                if (campagne == null) {
                  return const _Carte(
                    icone: Icons.event_busy,
                    titre: 'Aucune campagne ouverte',
                    sousTitre:
                        "Aucun inventaire n'est en cours. Un administrateur doit ouvrir une campagne.",
                  );
                }
                return _ContenuCampagne(session: session);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ContenuCampagne extends ConsumerWidget {
  final SessionState session;
  const _ContenuCampagne({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campagne = session.campagne!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.event_available),
            title: Text(campagne.nom),
            subtitle: Text('Ouverte depuis le ${campagne.dateDebut}'),
          ),
        ),
        const SizedBox(height: 16),
        Text('Contexte d’inventaire', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        _LigneContexte(label: 'Lieu', valeur: session.lieu?.nom),
        _LigneContexte(label: 'Service', valeur: session.service?.nom),
        _LigneContexte(
          label: 'Responsable',
          valeur: session.responsable.isEmpty ? null : session.responsable,
        ),
        _LigneContexte(
          label: 'Pièce',
          valeur: session.piece == null ? null : '${session.piece!.code} — ${session.piece!.libelle}',
        ),
        const SizedBox(height: 24),
        if (!session.pretAScanner)
          FilledButton.icon(
            onPressed: () => context.push('/contexte/lieu'),
            icon: const Icon(Icons.tune),
            label: Text(session.lieu == null ? 'Définir le contexte' : 'Continuer la configuration'),
          )
        else ...[
          FilledButton.icon(
            onPressed: () => context.push('/scan'),
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scanner des biens'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              ref.read(sessionProvider.notifier).changerPiece();
              context.push('/contexte/piece');
            },
            icon: const Icon(Icons.meeting_room_outlined),
            label: const Text('Changer de pièce'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              ref.read(sessionProvider.notifier).changerContexte();
              context.push('/contexte/lieu');
            },
            icon: const Icon(Icons.tune),
            label: const Text('Changer de contexte'),
          ),
        ],
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => context.push('/progression'),
          icon: const Icon(Icons.bar_chart),
          label: const Text('Voir la progression'),
        ),
      ],
    );
  }
}

class _LigneContexte extends StatelessWidget {
  final String label;
  final String? valeur;
  const _LigneContexte({required this.label, this.valeur});

  @override
  Widget build(BuildContext context) {
    final ok = valeur != null;
    return ListTile(
      dense: true,
      leading: Icon(ok ? Icons.check_circle : Icons.radio_button_unchecked,
          color: ok ? Colors.green : null),
      title: Text(label),
      subtitle: Text(valeur ?? 'Non défini'),
    );
  }
}

class _Carte extends StatelessWidget {
  final IconData icone;
  final String titre;
  final String sousTitre;
  final Widget? action;

  const _Carte({
    required this.icone,
    required this.titre,
    required this.sousTitre,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(icone, size: 56),
            const SizedBox(height: 12),
            Text(titre, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(sousTitre, textAlign: TextAlign.center),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
