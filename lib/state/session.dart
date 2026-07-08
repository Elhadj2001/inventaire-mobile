import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/refs.dart';
import '../services/api.dart';

class ScanRecent {
  final String numero;
  final String designation;
  final EtatConstate etat;
  final DateTime horodatage;

  const ScanRecent({
    required this.numero,
    required this.designation,
    required this.etat,
    required this.horodatage,
  });
}

class SessionState {
  final Campagne? campagne;
  final Lieu? lieu;
  final Service? service;
  final String responsable;
  final Piece? piece;
  final int nbScans;
  final List<ScanRecent> recents;

  const SessionState({
    this.campagne,
    this.lieu,
    this.service,
    this.responsable = '',
    this.piece,
    this.nbScans = 0,
    this.recents = const [],
  });

  bool get pretAScanner =>
      campagne != null && lieu != null && service != null && piece != null;

  SessionState copyWith({
    Campagne? campagne,
    Lieu? lieu,
    Service? service,
    String? responsable,
    Piece? piece,
    int? nbScans,
    List<ScanRecent>? recents,
    bool effacerLieu = false,
    bool effacerService = false,
    bool effacerPiece = false,
  }) {
    return SessionState(
      campagne: campagne ?? this.campagne,
      lieu: effacerLieu ? null : (lieu ?? this.lieu),
      service: effacerService ? null : (service ?? this.service),
      responsable: responsable ?? this.responsable,
      piece: effacerPiece ? null : (piece ?? this.piece),
      nbScans: nbScans ?? this.nbScans,
      recents: recents ?? this.recents,
    );
  }
}

class SessionController extends StateNotifier<SessionState> {
  SessionController() : super(const SessionState());

  void setCampagne(Campagne c) => state = state.copyWith(campagne: c);

  void setLieu(Lieu l) {
    // changer de lieu invalide le service et la pièce (dépendants du lieu)
    state = state.copyWith(lieu: l, effacerService: true, effacerPiece: true, recents: []);
  }

  void setService(Service s) => state = state.copyWith(service: s);

  void setResponsable(String r) => state = state.copyWith(responsable: r);

  void setPiece(Piece p) => state = state.copyWith(piece: p, recents: []);

  /// Changer de pièce : garde lieu/service/responsable.
  void changerPiece() => state = state.copyWith(effacerPiece: true, recents: []);

  /// Changer de contexte : repart du lieu (garde campagne + responsable).
  void changerContexte() =>
      state = state.copyWith(effacerLieu: true, effacerService: true, effacerPiece: true, recents: []);

  void ajouterScan(ScanRecent scan) {
    state = state.copyWith(
      nbScans: state.nbScans + 1,
      recents: [scan, ...state.recents].take(25).toList(),
    );
  }

  void reset() => state = const SessionState();
}

final sessionProvider = StateNotifierProvider<SessionController, SessionState>((ref) {
  return SessionController();
});

/// Charge la campagne ouverte au démarrage de la session connectée.
final campagneOuverteProvider = FutureProvider.autoDispose<Campagne?>((ref) async {
  final api = ref.watch(apiProvider);
  final c = await api.campagneOuverte();
  if (c != null) {
    ref.read(sessionProvider.notifier).setCampagne(c);
  }
  return c;
});
