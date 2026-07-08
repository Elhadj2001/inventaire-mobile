import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../data/database.dart';
import '../models/refs.dart';
import '../services/api.dart';
import '../state/session.dart';
import '../state/sync_state.dart';

class ContexteServiceScreen extends ConsumerStatefulWidget {
  const ContexteServiceScreen({super.key});

  @override
  ConsumerState<ContexteServiceScreen> createState() => _ContexteServiceScreenState();
}

class _ContexteServiceScreenState extends ConsumerState<ContexteServiceScreen> {
  final _recherche = TextEditingController();
  List<ServicesCacheData> _services = [];
  bool _chargement = true;
  bool _creation = false;

  @override
  void initState() {
    super.initState();
    _charger();
    _recherche.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _recherche.dispose();
    super.dispose();
  }

  Future<void> _charger() async {
    final lieu = ref.read(sessionProvider).lieu;
    if (lieu == null) return;
    setState(() => _chargement = true);
    final services = await ref.read(appDatabaseProvider).servicesDuLieu(lieu.id);
    if (mounted) {
      setState(() {
        _services = services;
        _chargement = false;
      });
    }
  }

  List<ServicesCacheData> get _filtres {
    final q = _recherche.text.trim().toLowerCase();
    if (q.isEmpty) return _services;
    return _services.where((s) => s.nom.toLowerCase().contains(q)).toList();
  }

  bool get _nomExactExiste {
    final q = _recherche.text.trim().toLowerCase();
    return _services.any((s) => s.nom.toLowerCase() == q);
  }

  /// Crée le service : tente le serveur (get-or-create) ; si hors ligne, crée un
  /// service provisoire local (remappé plus tard par la synchro).
  Future<void> _creerEtChoisir() async {
    final lieu = ref.read(sessionProvider).lieu!;
    final nom = _recherche.text.trim();
    setState(() => _creation = true);
    final db = ref.read(appDatabaseProvider);
    try {
      final service = await ref.read(apiProvider).creerService(lieu.id, nom);
      await db.into(db.servicesCache).insertOnConflictUpdate(
            ServicesCacheData(id: service.id, nom: service.nom, lieuId: service.lieuId, actif: true),
          );
      ref.read(sessionProvider.notifier).setService(service);
    } catch (_) {
      // Hors ligne : service provisoire local
      final localId = const Uuid().v4();
      await db.creerServiceProvisoire(
        ServicesLocauxCompanion.insert(localId: localId, lieuId: lieu.id, nom: nom),
      );
      await db.into(db.servicesCache).insertOnConflictUpdate(
            ServicesCacheData(id: localId, nom: nom, lieuId: lieu.id, actif: true),
          );
      ref.read(sessionProvider.notifier).setService(Service(id: localId, nom: nom, lieuId: lieu.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service créé hors ligne (sera synchronisé).')),
        );
      }
    } finally {
      if (mounted) setState(() => _creation = false);
    }
    if (mounted) context.push('/contexte/piece');
  }

  void _choisir(ServicesCacheData s) {
    ref.read(sessionProvider.notifier).setService(
          Service(id: s.id, nom: s.nom, lieuId: s.lieuId, actif: s.actif),
        );
    context.push('/contexte/piece');
  }

  @override
  Widget build(BuildContext context) {
    final lieu = ref.watch(sessionProvider).lieu;
    final saisie = _recherche.text.trim();
    return Scaffold(
      appBar: AppBar(title: Text('2. Service — ${lieu?.nom ?? ''}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _recherche,
              decoration: const InputDecoration(
                labelText: 'Rechercher ou saisir un service',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          if (saisie.isNotEmpty && !_nomExactExiste)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FilledButton.tonalIcon(
                onPressed: _creation ? null : _creerEtChoisir,
                icon: _creation
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.add),
                label: Text('Créer le service « $saisie »'),
              ),
            ),
          Expanded(
            child: _chargement
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: _filtres.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final s = _filtres[i];
                      return ListTile(
                        leading: const Icon(Icons.badge_outlined),
                        title: Text(s.nom),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _choisir(s),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
