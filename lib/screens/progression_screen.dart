import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/refs.dart';
import '../services/api.dart';
import '../state/session.dart';

final _progressionProvider = FutureProvider.autoDispose<Progression>((ref) {
  final campagne = ref.watch(sessionProvider).campagne;
  if (campagne == null) {
    throw 'Aucune campagne';
  }
  return ref.watch(apiProvider).progression(campagne.id);
});

class ProgressionScreen extends ConsumerWidget {
  const ProgressionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campagne = ref.watch(sessionProvider).campagne;
    final async = ref.watch(_progressionProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progression'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(_progressionProvider),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (prog) {
          final pct = prog.biensActifs == 0 ? 0.0 : prog.biensScannes / prog.biensActifs;
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(_progressionProvider),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (campagne != null)
                  Text(campagne.nom, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${prog.biensScannes} / ${prog.biensActifs} biens scannés',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(value: pct, minHeight: 10),
                        ),
                        const SizedBox(height: 4),
                        Text('${(pct * 100).toStringAsFixed(1)} %'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Détail par lieu', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final l in prog.parLieu)
                  ListTile(
                    leading: const Icon(Icons.place_outlined),
                    title: Text(l.lieuNom),
                    subtitle: Text(l.lieuCode),
                    trailing: Text('${l.biensScannes} scanné(s)'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
