import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/router.dart';
import 'app/theme.dart';

// Monitoring d'erreurs — DSN via --dart-define (même mécanique que l'URL d'API).
// Vide ou build debug => désactivé (rien envoyé).
const _sentryDsn = String.fromEnvironment('SENTRY_DSN', defaultValue: '');
const _sentryTest = bool.fromEnvironment('SENTRY_TEST', defaultValue: false);
const _appVersion = '1.3.1';

void main() {
  if (_sentryDsn.isEmpty || kDebugMode) {
    runApp(const ProviderScope(child: InventaireApp()));
    return;
  }
  SentryFlutter.init(
    (options) {
      options.dsn = _sentryDsn;
      options.release = 'inventaire-mobile@$_appVersion';
      options.environment = 'production';
      options.tracesSampleRate = 0.0; // pas de tracing perf (offre gratuite)
      options.sendDefaultPii = false;
    },
    appRunner: () {
      if (_sentryTest) {
        // Déclencheur de test (Lot 10) : build avec --dart-define=SENTRY_TEST=true.
        Sentry.captureException(
          Exception('Test Sentry mobile (Lot 10) — déclenché volontairement au démarrage.'),
        );
      }
      runApp(const ProviderScope(child: InventaireApp()));
    },
  );
}

class InventaireApp extends ConsumerWidget {
  const InventaireApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Inventaire IPD',
      theme: themeIpd(),
      routerConfig: router,
    );
  }
}
