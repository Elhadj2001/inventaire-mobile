import 'dart:io';

import 'package:dio/dio.dart';

import '../services/api.dart';
import 'database.dart';

class PousseResultat {
  final int creees;
  final int deja;
  final int rejetees;
  const PousseResultat(this.creees, this.deja, this.rejetees);
}

/// Orchestration de la synchronisation offline : référentiel (delta) et
/// remontée de la file (services provisoires -> photos -> lignes par lot).
class SyncRepository {
  SyncRepository(this._db, this._api);

  final AppDatabase _db;
  final ApiService _api;

  Future<void> rafraichirReferentiel() async {
    final depuis = await _db.lireMeta('referentiel_genere_le');
    final data = await _api.referentiel(depuis: depuis);
    await _db.appliquerReferentiel(data);
    await _db.ecrireMeta('referentiel_genere_le', data['genere_le'] as String);
    await _db.ecrireMeta('referentiel_maj_le', DateTime.now().toIso8601String());
  }

  Map<String, dynamic> _payload(ScansLocauxData s) => {
        'id': s.id,
        'campagne_id': s.campagneId,
        'numero_inventaire': s.numeroInventaire,
        'piece_id': s.pieceId,
        'service_id': s.serviceId,
        'responsable_equipement': ?s.responsable,
        'etat_constate': s.etat,
        'commentaire': ?s.commentaire,
        'photo_url': ?s.photoUrl,
        'scanne_le': s.scanneLe.toUtc().toIso8601String(),
      };

  /// Remonte la file. Ordre : services provisoires -> photos -> lignes par lot.
  /// Idempotent : rejouable sans doublon (id client + ON CONFLICT côté serveur).
  Future<PousseResultat> pousser() async {
    // 1. Services créés offline : get-or-create serveur puis remap de l'id local.
    for (final s in await _db.servicesLocauxNonSync()) {
      final service = await _api.creerService(s.lieuId, s.nom);
      await _db.remapperService(s.localId, service.id);
    }

    // 2. Photos locales pas encore uploadées.
    for (final scan in await _db.scansAvecPhotoAUploader()) {
      try {
        final url = await _api.uploadPhoto(scan.photoLocale!);
        await _db.definirPhotoUrl(scan.id, url);
      } on DioException catch (e) {
        // Cloudinary non configuré : la ligne partira sans photo (photo conservée en local).
        if (e.response?.statusCode == 503) continue;
        rethrow; // erreur réseau : on réessaiera au prochain passage
      } on FileSystemException {
        continue; // fichier photo introuvable : on part sans photo, sans bloquer la file
      }
    }

    // 3. Lignes en attente dont le service est résolu (id serveur présent).
    final enAttente = await _db.scansParStatut('en_attente');
    final pretes = enAttente.where((s) => s.serviceId != null).toList();
    if (pretes.isEmpty) return const PousseResultat(0, 0, 0);

    final resultats = await _api.syncLignes(pretes.map(_payload).toList());
    var creees = 0, deja = 0, rejetees = 0;
    for (final r in resultats) {
      if (r.rejete) {
        await _db.marquerResultat(r.id, 'rejete', r.motif);
        rejetees++;
      } else {
        await _db.marquerResultat(r.id, 'synchronise', null);
        r.statut == 'creee' ? creees++ : deja++;
      }
    }
    return PousseResultat(creees, deja, rejetees);
  }
}
