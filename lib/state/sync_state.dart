import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/sync_repository.dart';
import '../services/api.dart';
import 'session.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepository(ref.watch(appDatabaseProvider), ref.watch(apiProvider));
});

/// Nombre de scans en attente (réactif, pour le badge permanent).
final scansEnAttenteProvider = StreamProvider<int>((ref) {
  return ref.watch(appDatabaseProvider).watchEnAttente();
});

/// Fraîcheur du référentiel (« référentiel du JJ/MM à HH:MM »).
final referentielMajProvider = FutureProvider<DateTime?>((ref) async {
  final v = await ref.watch(appDatabaseProvider).lireMeta('referentiel_maj_le');
  return v == null ? null : DateTime.tryParse(v);
});

enum SyncPhase { idle, enCours, erreur }

class SyncStatus {
  final SyncPhase phase;
  final String? message;
  const SyncStatus(this.phase, [this.message]);
}

class SyncController extends StateNotifier<SyncStatus> {
  SyncController(this._ref) : super(const SyncStatus(SyncPhase.idle)) {
    _ecouterConnectivite();
  }

  final Ref _ref;
  StreamSubscription? _sub;
  bool _enCours = false;

  void _ecouterConnectivite() {
    _sub = Connectivity().onConnectivityChanged.listen((resultats) {
      final connecte = resultats.any((r) => r != ConnectivityResult.none);
      if (connecte) synchroniser();
    });
  }

  /// Rafraîchit le référentiel puis pousse la file. Verrou anti-concurrence.
  Future<void> synchroniser({bool referentiel = false}) async {
    if (_enCours) return;
    _enCours = true;
    state = const SyncStatus(SyncPhase.enCours);
    try {
      final repo = _ref.read(syncRepositoryProvider);
      if (referentiel) await repo.rafraichirReferentiel();
      final res = await repo.pousser();
      // Résumé des scans de la campagne ouverte (alerte « déjà scanné »).
      final campagne = _ref.read(sessionProvider).campagne;
      if (campagne != null) await repo.rafraichirScansCampagne(campagne.id);
      _ref.invalidate(referentielMajProvider);
      state = SyncStatus(
        SyncPhase.idle,
        '${res.creees} envoyé(s), ${res.deja} déjà, ${res.rejetees} rejeté(s)',
      );
    } catch (e) {
      state = SyncStatus(SyncPhase.erreur, '$e');
    } finally {
      _enCours = false;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final syncControllerProvider = StateNotifierProvider<SyncController, SyncStatus>((ref) {
  return SyncController(ref);
});
