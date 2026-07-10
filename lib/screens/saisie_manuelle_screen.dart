import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/database.dart';
import '../state/sync_state.dart';

/// Saisie manuelle d'un code illisible : le code (avec suggestions du cache) puis
/// le même flux de saisie (photo obligatoire côté écran de saisie).
class SaisieManuelleScreen extends ConsumerStatefulWidget {
  const SaisieManuelleScreen({super.key});

  @override
  ConsumerState<SaisieManuelleScreen> createState() => _SaisieManuelleScreenState();
}

class _SaisieManuelleScreenState extends ConsumerState<SaisieManuelleScreen> {
  final _code = TextEditingController();
  List<BiensCacheData> _suggestions = [];
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _code.dispose();
    super.dispose();
  }

  void _onChange(String v) {
    _debounce?.cancel();
    if (v.trim().length < 2) {
      setState(() => _suggestions = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      final res = await ref.read(appDatabaseProvider).chercherBiens(v);
      if (mounted) setState(() => _suggestions = res);
    });
  }

  void _continuer(String code) {
    final c = code.trim();
    if (c.isEmpty) return;
    context.push('/saisie/${Uri.encodeComponent(c)}?manuelle=1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saisie manuelle')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Étiquette illisible ? Saisissez le numéro d’inventaire. Les suggestions ci-dessous '
            'aident à éviter les fautes. Une photo sera exigée à l’étape suivante.',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _code,
            autofocus: true,
            textInputAction: TextInputAction.go,
            onChanged: _onChange,
            onSubmitted: _continuer,
            decoration: const InputDecoration(
              labelText: 'Numéro d’inventaire',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.keyboard),
            ),
          ),
          const SizedBox(height: 8),
          for (final b in _suggestions)
            ListTile(
              dense: true,
              leading: const Icon(Icons.inventory_2_outlined),
              title: Text(b.numeroInventaire),
              subtitle: Text(b.designation, maxLines: 1, overflow: TextOverflow.ellipsis),
              onTap: () {
                _code.text = b.numeroInventaire;
                _continuer(b.numeroInventaire);
              },
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _continuer(_code.text),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Continuer'),
          ),
        ],
      ),
    );
  }
}
