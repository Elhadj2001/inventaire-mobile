import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/database.dart';
import '../models/refs.dart';
import '../state/session.dart';
import '../state/sync_state.dart';

// Lecture depuis le cache local (offline).
final _lieuxCacheProvider = FutureProvider.autoDispose<List<LieuxCacheData>>((ref) {
  return ref.watch(appDatabaseProvider).lieux();
});

class ContexteLieuScreen extends ConsumerWidget {
  const ContexteLieuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_lieuxCacheProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('1. Choisir le lieu')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (lieux) {
          if (lieux.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Référentiel non encore téléchargé.\nConnectez-vous une fois avec du réseau.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: lieux.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final l = lieux[i];
              return ListTile(
                leading: CircleAvatar(child: Text(l.code.substring(2))),
                title: Text(l.nom),
                subtitle: Text(l.code),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ref.read(sessionProvider.notifier).setLieu(
                        Lieu(id: l.id, code: l.code, nom: l.nom),
                      );
                  context.push('/contexte/service');
                },
              );
            },
          );
        },
      ),
    );
  }
}
