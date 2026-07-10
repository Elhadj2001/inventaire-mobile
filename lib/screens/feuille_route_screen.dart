import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/theme.dart';
import '../data/database.dart';
import '../models/refs.dart';
import '../state/session.dart';
import '../state/sync_state.dart';

final _affectationsProvider = FutureProvider.autoDispose<List<AffectationsCacheData>>((ref) {
  final campagne = ref.watch(sessionProvider).campagne;
  if (campagne == null) return Future.value([]);
  return ref.watch(appDatabaseProvider).mesAffectations(campagne.id);
});

class FeuilleRouteScreen extends ConsumerWidget {
  const FeuilleRouteScreen({super.key});

  Future<void> _inventorier(BuildContext context, WidgetRef ref, AffectationsCacheData a) async {
    final db = ref.read(appDatabaseProvider);
    final notifier = ref.read(sessionProvider.notifier);

    if (a.lieuId != null) {
      final lieu = await db.lieuParId(a.lieuId!);
      if (lieu != null) notifier.setLieu(Lieu(id: lieu.id, code: lieu.code, nom: lieu.nom));
    }
    if (a.type == 'piece' && a.pieceId != null) {
      // service par défaut de la pièce (si présent)
      if (a.serviceId != null) {
        final s = await db.serviceParId(a.serviceId!);
        if (s != null) notifier.setService(Service(id: s.id, nom: s.nom, lieuId: s.lieuId));
      }
      final p = await db.pieceParId(a.pieceId!);
      if (p != null) {
        notifier.setPiece(Piece(
          id: p.id, code: p.code, libelle: p.libelle,
          batiment: p.batiment, niveau: p.niveau, lieuId: p.lieuId, serviceId: p.serviceId,
        ));
      }
    }
    if (!context.mounted) return;
    // pièce complète -> scanner directement ; sinon poursuivre le choix du service
    if (ref.read(sessionProvider).pretAScanner) {
      context.go('/');
      context.push('/scan');
    } else {
      context.go('/');
      context.push('/contexte/service');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_affectationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma feuille de route'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(_affectationsProvider)),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (affs) {
          if (affs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Aucune affectation.\nL’administrateur peut vous assigner des lieux ou des pièces.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text(
                  'Vos affectations (indicatives : vous pouvez aussi scanner ailleurs).',
                  style: TextStyle(color: IpdCouleurs.muet),
                ),
              ),
              for (final a in affs) _carteAffectation(context, ref, a),
            ],
          );
        },
      ),
    );
  }

  Widget _carteAffectation(BuildContext context, WidgetRef ref, AffectationsCacheData a) {
    final complet = a.piecesAffectees > 0 && a.piecesScannees >= a.piecesAffectees;
    return Card(
      child: ListTile(
        leading: Icon(
          complet ? Icons.check_circle : (a.type == 'lieu' ? Icons.place : Icons.meeting_room_outlined),
          color: complet ? IpdCouleurs.vert : IpdCouleurs.bleu,
        ),
        title: Text(a.type == 'lieu'
            ? (a.lieuNom ?? 'Lieu')
            : '${a.pieceCode ?? ''} — ${a.pieceLibelle ?? ''}'),
        subtitle: Text(
          '${a.piecesScannees}/${a.piecesAffectees} pièce(s) couverte(s) · ${a.nbScans} scan(s)'
          '${a.type == 'piece' ? '' : ' · ${a.lieuNom ?? ''}'}',
        ),
        trailing: FilledButton(
          onPressed: () => _inventorier(context, ref, a),
          child: const Text('Inventorier'),
        ),
      ),
    );
  }
}
