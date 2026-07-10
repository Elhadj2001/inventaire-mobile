import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../app/theme.dart';
import '../state/auth.dart';
import '../state/session.dart';
import '../state/sync_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // À l'arrivée sur l'accueil : rafraîchit le référentiel (delta) + pousse la file.
    Future.microtask(
      () => ref.read(syncControllerProvider.notifier).synchroniser(referentiel: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final campagneAsync = ref.watch(campagneOuverteProvider);
    final session = ref.watch(sessionProvider);
    final enAttente = ref.watch(scansEnAttenteProvider).valueOrNull ?? 0;
    final sync = ref.watch(syncControllerProvider);

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
        onRefresh: () async {
          ref.invalidate(campagneOuverteProvider);
          await ref.read(syncControllerProvider.notifier).synchroniser(referentiel: true);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _BandeauSync(enAttente: enAttente, sync: sync),
            const SizedBox(height: 12),
            campagneAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => _Carte(
                icone: Icons.cloud_off,
                titre: 'Hors ligne ou serveur injoignable',
                sousTitre:
                    'Vous pouvez continuer à inventorier si le référentiel est en cache ; la synchro reprendra au réseau.\n\n$e',
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
                    sousTitre: "Aucun inventaire n'est en cours.",
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

class _BandeauSync extends ConsumerWidget {
  final int enAttente;
  final SyncStatus sync;
  const _BandeauSync({required this.enAttente, required this.sync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maj = ref.watch(referentielMajProvider).valueOrNull;
    final fraicheur = maj == null
        ? 'référentiel non téléchargé'
        : 'référentiel du ${DateFormat('dd/MM à HH:mm').format(maj)}';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  enAttente > 0 ? Icons.cloud_upload : Icons.cloud_done,
                  color: enAttente > 0 ? IpdCouleurs.ambre : IpdCouleurs.vert,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    enAttente > 0 ? '$enAttente scan(s) en attente' : 'Tout est synchronisé',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: sync.phase == SyncPhase.enCours
                      ? null
                      : () => ref.read(syncControllerProvider.notifier).synchroniser(referentiel: true),
                  child: sync.phase == SyncPhase.enCours
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Synchroniser'),
                ),
              ],
            ),
            Text(fraicheur, style: Theme.of(context).textTheme.bodySmall),
            if (sync.phase == SyncPhase.erreur)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Dernière synchro : ${sync.message}',
                    style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => context.push('/file'),
                icon: const Icon(Icons.list_alt, size: 18),
                label: const Text('Voir la file de synchronisation'),
              ),
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
        const _ScansDuJour(),
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () => context.push('/feuille-route'),
                icon: const Icon(Icons.assignment_outlined),
                label: const Text('Ma feuille de route'),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () => context.push('/progression'),
                icon: const Icon(Icons.bar_chart),
                label: const Text('Progression'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final _scansDuJourProvider = FutureProvider.autoDispose<int>((ref) async {
  final n = DateTime.now();
  final debut = DateTime(n.year, n.month, n.day);
  final scans = await ref.watch(appDatabaseProvider).scansDuJour(debut);
  return scans.length;
});

/// Compteur des scans de la journée (données locales, lisible offline).
class _ScansDuJour extends ConsumerWidget {
  const _ScansDuJour();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(_scansDuJourProvider).valueOrNull ?? 0;
    return Card(
      color: IpdCouleurs.bleuTint,
      child: ListTile(
        leading: const Icon(Icons.today, color: IpdCouleurs.bleuFonce),
        title: Text('$n scan(s) aujourd’hui', style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: const Text('sur cet appareil'),
      ),
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
          color: ok ? IpdCouleurs.vert : null),
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
