import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/refs.dart';
import '../services/api.dart';
import '../state/session.dart';

final _lieuxProvider = FutureProvider.autoDispose<List<Lieu>>((ref) {
  return ref.watch(apiProvider).lieux();
});

class ContexteLieuScreen extends ConsumerWidget {
  const ContexteLieuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lieuxAsync = ref.watch(_lieuxProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('1. Choisir le lieu')),
      body: lieuxAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off, size: 56),
                const SizedBox(height: 12),
                Text('$e', textAlign: TextAlign.center),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => ref.invalidate(_lieuxProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
        data: (lieux) => ListView.separated(
          itemCount: lieux.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final lieu = lieux[i];
            return ListTile(
              leading: CircleAvatar(child: Text(lieu.code.substring(2))),
              title: Text(lieu.nom),
              subtitle: Text(lieu.code),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ref.read(sessionProvider.notifier).setLieu(lieu);
                context.push('/contexte/service');
              },
            );
          },
        ),
      ),
    );
  }
}
