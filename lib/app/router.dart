import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/contexte_lieu_screen.dart';
import '../screens/contexte_piece_screen.dart';
import '../screens/contexte_service_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/progression_screen.dart';
import '../screens/saisie_screen.dart';
import '../screens/scan_screen.dart';
import '../state/auth.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: _AuthListenable(ref),
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      if (!auth.isKnown) return null; // bootstrap en cours
      final surLogin = state.matchedLocation == '/login';
      if (!auth.isAuthenticated) return surLogin ? null : '/login';
      if (surLogin) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
      GoRoute(path: '/', builder: (c, s) => const HomeScreen()),
      GoRoute(path: '/contexte/lieu', builder: (c, s) => const ContexteLieuScreen()),
      GoRoute(path: '/contexte/service', builder: (c, s) => const ContexteServiceScreen()),
      GoRoute(path: '/contexte/piece', builder: (c, s) => const ContextePieceScreen()),
      GoRoute(path: '/scan', builder: (c, s) => const ScanScreen()),
      GoRoute(
        path: '/saisie/:numero',
        builder: (c, s) => SaisieScreen(numero: s.pathParameters['numero']!),
      ),
      GoRoute(path: '/progression', builder: (c, s) => const ProgressionScreen()),
    ],
  );
});

/// Rebâtit les redirections quand l'état d'auth change.
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(Ref ref) {
    ref.listen(authControllerProvider, (_, _) => notifyListeners());
  }
}
