import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../app/theme.dart';
import '../data/database.dart';
import '../state/sync_state.dart';

final _scansProvider = FutureProvider.autoDispose<List<ScansLocauxData>>((ref) {
  return ref.watch(appDatabaseProvider).tousLesScans();
});

class FileScreen extends ConsumerWidget {
  const FileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_scansProvider);
    final sync = ref.watch(syncControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('File de synchronisation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(_scansProvider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: sync.phase == SyncPhase.enCours
            ? null
            : () async {
                await ref.read(syncControllerProvider.notifier).synchroniser(referentiel: true);
                ref.invalidate(_scansProvider);
              },
        icon: const Icon(Icons.sync),
        label: const Text('Synchroniser'),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (scans) {
          if (scans.isEmpty) {
            return const Center(child: Text('Aucun scan local.'));
          }
          final heure = DateFormat('dd/MM HH:mm:ss');
          return ListView.separated(
            itemCount: scans.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final s = scans[i];
              final (icone, couleur) = switch (s.statut) {
                'synchronise' => (Icons.cloud_done, IpdCouleurs.vert),
                'rejete' => (Icons.error_outline, IpdCouleurs.rouge),
                _ => (Icons.schedule, IpdCouleurs.ambre),
              };
              return ListTile(
                leading: Icon(icone, color: couleur),
                title: Text('${s.numeroInventaire} — ${s.etat}'),
                subtitle: Text(
                  '${heure.format(s.scanneLe)} · ${_libelleStatut(s.statut)}'
                  '${s.motif != null ? '\nMotif : ${s.motif}' : ''}'
                  '${s.photoLocale != null && s.photoUrl == null ? '\n📷 photo en attente d\'upload' : ''}',
                ),
                isThreeLine: s.motif != null,
              );
            },
          );
        },
      ),
    );
  }

  String _libelleStatut(String statut) => switch (statut) {
        'synchronise' => 'synchronisé',
        'rejete' => 'REJETÉ',
        _ => 'en attente',
      };
}
