import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/refs.dart';
import '../services/api.dart';
import '../state/session.dart';

class ContexteServiceScreen extends ConsumerStatefulWidget {
  const ContexteServiceScreen({super.key});

  @override
  ConsumerState<ContexteServiceScreen> createState() => _ContexteServiceScreenState();
}

class _ContexteServiceScreenState extends ConsumerState<ContexteServiceScreen> {
  final _recherche = TextEditingController();
  List<Service> _services = [];
  bool _chargement = true;
  bool _creation = false;
  String? _erreur;

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
    setState(() {
      _chargement = true;
      _erreur = null;
    });
    try {
      final services = await ref.read(apiProvider).services(lieu.id);
      if (mounted) setState(() => _services = services);
    } catch (e) {
      if (mounted) setState(() => _erreur = '$e');
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  List<Service> get _filtres {
    final q = _recherche.text.trim().toLowerCase();
    if (q.isEmpty) return _services;
    return _services.where((s) => s.nom.toLowerCase().contains(q)).toList();
  }

  bool get _nomExactExiste {
    final q = _recherche.text.trim().toLowerCase();
    return _services.any((s) => s.nom.toLowerCase() == q);
  }

  Future<void> _creerEtChoisir() async {
    final lieu = ref.read(sessionProvider).lieu!;
    setState(() => _creation = true);
    try {
      final service = await ref.read(apiProvider).creerService(lieu.id, _recherche.text.trim());
      ref.read(sessionProvider.notifier).setService(service);
      if (mounted) context.push('/contexte/piece');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Échec : $e')));
      }
    } finally {
      if (mounted) setState(() => _creation = false);
    }
  }

  void _choisir(Service service) {
    ref.read(sessionProvider.notifier).setService(service);
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
                : _erreur != null
                    ? Center(child: Text(_erreur!))
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
