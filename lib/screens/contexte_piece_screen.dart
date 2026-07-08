import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/refs.dart';
import '../services/api.dart';
import '../state/session.dart';

class ContextePieceScreen extends ConsumerStatefulWidget {
  const ContextePieceScreen({super.key});

  @override
  ConsumerState<ContextePieceScreen> createState() => _ContextePieceScreenState();
}

class _ContextePieceScreenState extends ConsumerState<ContextePieceScreen> {
  final _responsable = TextEditingController();
  final _recherche = TextEditingController();
  List<Piece> _pieces = [];
  bool _chargement = true;
  String? _erreur;
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
    _debounce = Timer(const Duration(milliseconds: 350), _charger);
  }

  Future<void> _charger() async {
    final session = ref.read(sessionProvider);
    final lieu = session.lieu;
    if (lieu == null) return;
    setState(() {
      _chargement = true;
      _erreur = null;
    });
    try {
      // Pièces du service choisi d'abord, puis les autres du lieu.
      final api = ref.read(apiProvider);
      final q = _recherche.text.trim();
      final duService = session.service == null
          ? <Piece>[]
          : await api.pieces(lieu.id, q: q, serviceId: session.service!.id);
      final duLieu = await api.pieces(lieu.id, q: q);
      final idsService = duService.map((p) => p.id).toSet();
      final autres = duLieu.where((p) => !idsService.contains(p.id)).toList();
      if (mounted) setState(() => _pieces = [...duService, ...autres]);
    } catch (e) {
      if (mounted) setState(() => _erreur = '$e');
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  void _choisir(Piece piece) {
    final notifier = ref.read(sessionProvider.notifier);
    notifier.setResponsable(_responsable.text.trim());
    notifier.setPiece(piece);
    // Contexte complet : retour à l'accueil (pile réinitialisée).
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
                : _erreur != null
                    ? Center(child: Text(_erreur!))
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
