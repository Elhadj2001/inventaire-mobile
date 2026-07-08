import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/database.dart';
import '../models/refs.dart';
import '../state/session.dart';
import '../state/sync_state.dart';

class ContextePieceScreen extends ConsumerStatefulWidget {
  const ContextePieceScreen({super.key});

  @override
  ConsumerState<ContextePieceScreen> createState() => _ContextePieceScreenState();
}

class _ContextePieceScreenState extends ConsumerState<ContextePieceScreen> {
  final _responsable = TextEditingController();
  final _recherche = TextEditingController();
  List<PiecesCacheData> _pieces = [];
  bool _chargement = true;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _responsable.text = ref.read(sessionProvider).responsable;
    _charger();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _responsable.dispose();
    _recherche.dispose();
    super.dispose();
  }

  void _onRechercheChange(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _charger);
  }

  Future<void> _charger() async {
    final session = ref.read(sessionProvider);
    final lieu = session.lieu;
    if (lieu == null) return;
    setState(() => _chargement = true);
    final db = ref.read(appDatabaseProvider);
    final toutes = await db.piecesDuLieu(lieu.id, q: _recherche.text);
    // Pièces rattachées au service choisi d'abord.
    final serviceId = session.service?.id;
    toutes.sort((a, b) {
      final aRatt = serviceId != null && a.serviceId == serviceId ? 0 : 1;
      final bRatt = serviceId != null && b.serviceId == serviceId ? 0 : 1;
      if (aRatt != bRatt) return aRatt - bRatt;
      return a.code.compareTo(b.code);
    });
    if (mounted) {
      setState(() {
        _pieces = toutes;
        _chargement = false;
      });
    }
  }

  void _choisir(PiecesCacheData p) {
    final notifier = ref.read(sessionProvider.notifier);
    notifier.setResponsable(_responsable.text.trim());
    notifier.setPiece(Piece(
      id: p.id,
      code: p.code,
      libelle: p.libelle,
      batiment: p.batiment,
      niveau: p.niveau,
      lieuId: p.lieuId,
      serviceId: p.serviceId,
    ));
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final serviceId = session.service?.id;
    return Scaffold(
      appBar: AppBar(title: Text('3. Pièce — ${session.lieu?.nom ?? ''}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _responsable,
              decoration: const InputDecoration(
                labelText: 'Responsable d’équipement (optionnel)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: TextField(
              controller: _recherche,
              onChanged: _onRechercheChange,
              decoration: const InputDecoration(
                labelText: 'Rechercher une pièce (code ou libellé)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _chargement
                ? const Center(child: CircularProgressIndicator())
                : _pieces.isEmpty
                    ? const Center(child: Text('Aucune pièce'))
                    : ListView.separated(
                        itemCount: _pieces.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final p = _pieces[i];
                          final rattachee = serviceId != null && p.serviceId == serviceId;
                          return ListTile(
                            leading: Icon(
                              Icons.meeting_room_outlined,
                              color: rattachee ? Theme.of(context).colorScheme.primary : null,
                            ),
                            title: Text(p.libelle),
                            subtitle: Text(p.code),
                            trailing: rattachee
                                ? const Chip(label: Text('service'), visualDensity: VisualDensity.compact)
                                : const Icon(Icons.chevron_right),
                            onTap: () => _choisir(p),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
