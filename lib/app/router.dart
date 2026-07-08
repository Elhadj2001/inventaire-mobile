import 'package:go_router/go_router.dart';

import '../screens/bien_screen.dart';
import '../screens/home_screen.dart';
import '../screens/qr_test_screen.dart';
import '../screens/scan_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/scan', builder: (context, state) => const ScanScreen()),
    GoRoute(
      path: '/bien/:numero',
      builder: (context, state) =>
          BienScreen(numero: state.pathParameters['numero']!),
    ),
    GoRoute(path: '/qr-test', builder: (context, state) => const QrTestScreen()),
  ],
);
